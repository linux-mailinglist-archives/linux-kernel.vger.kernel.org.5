Return-Path: <linux-kernel+bounces-65919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA3A8553BA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A855B2A44F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDE513DBA8;
	Wed, 14 Feb 2024 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iJWUD7/o"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67061E4B7;
	Wed, 14 Feb 2024 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941444; cv=none; b=UTzjREdg5fYoptCoKNLji22wq5aMwsv6j6DX4fnVZWVISbB0L2Rz/lbfYVaymlnmMhPKuQIxreTNtTtQ5xPJ2UsRN5Oic4ExwJE7H65AJ6Dsu4+4lzssqUalnAkCuI8R7zccnWtD/vz+ptjS0M/jFfguzXb2n0ITNGIEIIv5tIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941444; c=relaxed/simple;
	bh=3DEw2bejqdHv83RpCK7MpKXxCnwuuzs/j5eNYOI6FDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWF0TsBQ4zeg1nnYcHshRDY0olyExiX+XFR7QqJWnoeTkcHTV9lLWbHII3RmN+5BGsvoaM3uO3AECBecn+4W08zZe6EP65vIBRwxrUna4TIWtsspP6LuTA6jVV1bJqaXxZTkL42OmqrYeS1tRN5n8UkNhk8DoqUzuk8k+Ot0WeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iJWUD7/o; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B8B9C40E023B;
	Wed, 14 Feb 2024 20:10:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3A5CcIbVRZVG; Wed, 14 Feb 2024 20:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707941437; bh=v2uz5bkFJIe38UIfTC8p/jckQNb9Ysmp7VG4BbqORTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJWUD7/oGN40FjfLmH/w7fAMdN5mLk8XUFcK3l64gZefjxlzaQvFMxA7yFrkDJs8M
	 1zi23ZIDBqvf7RD5k4nIESAsrX2GZZZtDU/B1K8phXzQlXSKxK5Ffn2XL4nFwTNe52
	 5EbOGGWPaaoPbSplgbWSy8G8kligyFfS9zVdzyZYhjz1ceK/sxYUb5YbAA+l1XLCR5
	 a4Y4540umqxp7CPQJxnEoUUCZcVxZew7OoZE1wsd7CnZwjb51pjFUDkRe2EE9vZNVw
	 tlCcoCovENidhe7j+a7MvtFE/hr/q567m/mpxOHZE+s6B2ulnuOxD1Z65gSHYlRa/P
	 6wPZsADGsS1gc47CxxcTs/KScKgSmoYoktRQytrQ4FICD2KzUvj9yALHrBArjtK8uL
	 eNqdkpJa6IZvA7rdpgeBRgZHNbOFLVZ3k2hiNdcLYWd0mQfxVQf3XneK5VnQrEGxhs
	 wbVXvPY4gm4oIgAPdPBOAjfUIsoliTeDXQQ4mqLds5VioapliEJLCv1pKXgbn2w5HZ
	 bN26D7SYo71hcQ+C11uLpbmoR9COUaUEnvld45fZFfrE0JhJO1OkU9r+/9LX/vudCT
	 KhDHQ/wrrzbh0H1uABdEbVtgAkCxM4F7PONVc9NdPubngfxdXWn2qb7ylxHsagm5hf
	 VlUtV+p3nYa3KMQebKgf2R+s=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4093340E01A9;
	Wed, 14 Feb 2024 20:10:28 +0000 (UTC)
Date: Wed, 14 Feb 2024 21:10:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214201021.GQZc0eLX1AXV-PwE1K@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214113630.GIZcylvp6-m-FNNE7H@fat_crate.local>
 <4096ae55-62bb-4705-94dc-ccf90ee64988@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4096ae55-62bb-4705-94dc-ccf90ee64988@amd.com>

On Wed, Feb 14, 2024 at 10:26:41AM -0500, Yazen Ghannam wrote:
> > > +static bool is_valid_fmp(struct fru_rec *rec)
> > 
> > fmp_is_valid()
> > 
> 
> Ack.

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index bcee828cb916..3600bf0dca53 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -447,7 +447,7 @@ static int save_new_records(void)
 	return ret;
 }
 
-static bool is_valid_fmp(struct fru_rec *rec)
+static bool fmp_is_valid(struct fru_rec *rec)
 {
 	struct cper_sec_fru_mem_poison *fmp = &rec->fmp;
 	u32 len = get_fmp_len(rec);
@@ -486,19 +486,12 @@ static bool is_valid_fmp(struct fru_rec *rec)
 	return true;
 }
 
-static void restore_record(struct fru_rec *new, struct fru_rec *old)
-{
-	/* Records larger than max_rec_len were skipped earlier. */
-	size_t len = min(max_rec_len, old->hdr.record_length);
-
-	memcpy(new, old, len);
-}
-
 static bool valid_record(struct fru_rec *old)
 {
 	struct fru_rec *new;
+	size_t len;
 
-	if (!is_valid_fmp(old)) {
+	if (!fmp_is_valid(old)) {
 		pr_debug("Ignoring invalid record");
 		return false;
 	}
@@ -509,8 +502,11 @@ static bool valid_record(struct fru_rec *old)
 		return false;
 	}
 
-	/* What if ERST has duplicate FRU entries? */
-	restore_record(new, old);
+	/* Records larger than max_rec_len were skipped earlier. */
+	len = min(max_rec_len, old->hdr.record_length);
+
+	/* Restore the record */
+	memcpy(new, old, len);
 
 	return true;
 }

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

