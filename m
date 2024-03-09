Return-Path: <linux-kernel+bounces-98037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F798773F3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1385281BB9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 20:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B2E4F20A;
	Sat,  9 Mar 2024 20:46:01 +0000 (UTC)
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C7941C6A
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710017161; cv=none; b=T3iNMhmVRdCxuGDxSMNMdLBIL5hsU1gp7rvKCZK2iXw7yPuSToE2ToHhlV2QwXw5CIQKif2BZSqMHekCQB9drFDT4Ectd5LV/P+mWP31VxJK6ZkzPvTJxQeO+N9/dTSq4+zut1uVi0/lI3luKfI8eoYHKSR6PAKSZ78g3dg4xPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710017161; c=relaxed/simple;
	bh=ZPLcAC1idEQsrEeiIpSoNAiCCJvbQ4JoAxAN+zaBGQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gvvvRt6AecxcreZnDxxFmGBKLib79rBFfo4nvzSizsMUHMsTIAzTiHjGhmfYppSzx1W54R7mnEES7WaMih9IVNR3iiLMUqgI0ESblKzKNoQWcBKU/xuEX/7cjComi0nt/Jkzm21AmE/9LvfM/73AePcCxqfjNB+SmuTppBpw5tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id A00C7A02B9;
	Sat,  9 Mar 2024 21:35:50 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eP4BFBAT6w_l; Sat,  9 Mar 2024 21:35:50 +0100 (CET)
Received: from begin (aamiens-653-1-111-57.w83-192.abo.wanadoo.fr [83.192.234.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 3C28CA02B8;
	Sat,  9 Mar 2024 21:35:50 +0100 (CET)
Received: from samy by begin with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1rj3Q5-00000001EM3-3UMS;
	Sat, 09 Mar 2024 21:35:49 +0100
Date: Sat, 9 Mar 2024 21:35:49 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCH] speakup: Fix warning for label at end of compound statement
Message-ID: <20240309203549.jj2l6epnznyjsrje@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	speakup@linux-speakup.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)

Label at end of compound statements is a C2x extension, so add an empty instruction.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reported-by: kernel test robot <lkp@intel.com>
Fixes: 807977260ae4 ("speakup: Add /dev/synthu device")
Closes: https://lore.kernel.org/oe-kbuild-all/202403090122.cpUNsozM-lkp@intel.com/

Index: linux-6.4/drivers/accessibility/speakup/devsynth.c
===================================================================
--- linux-6.4.orig/drivers/accessibility/speakup/devsynth.c
+++ linux-6.4/drivers/accessibility/speakup/devsynth.c
@@ -108,6 +108,7 @@ static ssize_t speakup_file_writeu(struc
 				break;
 			}
 drop:
+			;
 		}
 
 		count -= bytes;

