Return-Path: <linux-kernel+bounces-51228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5835D848817
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAB41C21C04
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D8A5FBBA;
	Sat,  3 Feb 2024 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="n81vRCmS"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B28B5FBA9
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706983066; cv=none; b=c8mOzU4qABs3JeVeabaEkuIycGFGlQYibUgQS+wu8IPDRMa9seUKr1lkV7eUhyzdiZhBQ/xlPJKIo882iVeJ1HR3aT5t4vh+3NGRbwOUeJnBdRZ3ZI56jh5zDBaR7S44Tk5PE47JszBu5KGSqcY4ux+BYlHUMZby9cfXDB1BT+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706983066; c=relaxed/simple;
	bh=L5XYF2KuEo1BrAG7ckKe76GQrqm8pMIi0dIvttW0n/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvrrXkBZIJxfIfYdunfp9FarxF6H7pDEan76Ci8vJyWwGztRNRrhN3LLdS5IPXPgm9/dj3AG3XWaCfc4cwNs6asltnDaXhje+/+wI8eS8Sojwl+keCr8XmsnFnig2jM1DCwx1H9U94rFwho7DpPRQMcoL36DfW7XblkDMLqLzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=n81vRCmS; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-236.bstnma.fios.verizon.net [173.48.82.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 413Hv0J2016980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Feb 2024 12:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706983023; bh=cgektm8Q7wvIKkcrsOa9PWTVTa13uIiTg1vywPCUM4Q=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=n81vRCmSk5GvNTiXt3ljeqomzIgwcMUo5S6oAocqScuncfnGHRQ6R3RHyqAdMlEpn
	 HktVRHFGsKiNMvi5miX4LLjzTm6Ayn4SMzu0eMbJd9ZM2hzTGo+RdL0RH651HO047O
	 5o+Up20WUjt4fnEssoNFAh5pwcuRE6WsabSdb0ql+WvA7TG2PP8vleQhJP/bLCeNbN
	 o1nObKq9Q+sqyYkZ86cudLcGYvwdjcXBJa4lY0tr2h6fLGh92MDk0wtSzopH7/GO91
	 iH3lV/q7iJOYmzerxB2i43FRIEHnbo0eahb0sqkktp5lmQeNVzDSa1CnQQ5w1yfn2t
	 Im+y23yeZB2Rw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5574C15C02FC; Sat,  3 Feb 2024 12:57:00 -0500 (EST)
Date: Sat, 3 Feb 2024 12:57:00 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        hch@infradead.org, djwong@kernel.org, willy@infradead.org,
        zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 05/26] ext4: make ext4_map_blocks() distinguish
 delalloc only extent
Message-ID: <20240203175700.GH36616@mit.edu>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127015825.1608160-6-yi.zhang@huaweicloud.com>

On Sat, Jan 27, 2024 at 09:58:04AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Add a new map flag EXT4_MAP_DELAYED to indicate the mapping range is a
> delayed allocated only (not unwritten) one, and making
> ext4_map_blocks() can distinguish it, no longer mixing it with holes.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.


