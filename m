Return-Path: <linux-kernel+bounces-13204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8DC820119
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11C91C2189B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0444A12B92;
	Fri, 29 Dec 2023 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u0eehce0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE08612B93
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 29 Dec 2023 13:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703876096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=foI3BeWGtWNh75wzfz6IrCcvUtBQLjp/z/XKEKBzVhY=;
	b=u0eehce0bxNGwlmKU/aq20IQw+j5KErIRGrefwyqbpu8QEP7ok4N5q2s6dC3Tf+hZMvJGa
	pBfraAY7XoVBLi2q+5+LV4p+nrsGyntsMo2CRRF5R1gOVi9jZu/icKilwnvogLpOT9bdKG
	kv3qc7dmP9OX5vnpmX2uxp4g28ztvOY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Daniel J Blueman <daniel@quora.org>
Cc: linux-bcachefs@vger.kernel.org, 
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Stack corruption in bch2_nocow_write
Message-ID: <jt3gy5v3jhqadakhxbdezvfo2n2f4n7sc52ljw4kztct6poihr@zork6muwdity>
References: <CAMVG2su=Kt5mkyEHGh5D4YH+1xTUFX3BhOjf-D0bcRTntav3ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMVG2su=Kt5mkyEHGh5D4YH+1xTUFX3BhOjf-D0bcRTntav3ng@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 29, 2023 at 07:43:13PM +0800, Daniel J Blueman wrote:
> Hi Kent et al,
> 
> On Linux 6.7-rc7 from bcachefs master SHA f3608cbdfd built with UBSAN
> [1], with a crafted workload [2] I'm able to trigger stack corruption
> in bch2_nocow_write [3].
> 
> Let me know if you can't reproduce it and I'll check reproducibility
> on another platform, and let me know for any patch testing.

this should be fixed in the testing branch:

commit ab35f724070ccdaa31f6376a1890473e7d031ed0
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Fri Dec 29 13:54:00 2023 -0500

    bcachefs: fix nocow write path when writing to multiple extents
    
    Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/fs/bcachefs/io_write.c b/fs/bcachefs/io_write.c
index c5961bac19f0..7c5963cd0b85 100644
--- a/fs/bcachefs/io_write.c
+++ b/fs/bcachefs/io_write.c
@@ -1316,6 +1316,7 @@ static void bch2_nocow_write(struct bch_write_op *op)
 		closure_get(&op->cl);
 		bch2_submit_wbio_replicas(to_wbio(bio), c, BCH_DATA_user,
 					  op->insert_keys.top, true);
+		nr_buckets = 0;
 
 		bch2_keylist_push(&op->insert_keys);
 		if (op->flags & BCH_WRITE_DONE)

