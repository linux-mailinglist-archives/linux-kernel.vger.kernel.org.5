Return-Path: <linux-kernel+bounces-138987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C10DE89FD0F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2C52B29187
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567B617B4EC;
	Wed, 10 Apr 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hFqXtdee"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1512B17B514
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766982; cv=none; b=nca2XT3EjySSs4W63dOiSMCItTWtBzg3BTt/dgLp+KNGuuoCiBrYWLOXHJOZBDmqXKw4peBwfHxyVeTnKkZIRJrzHdbrdj8Mv9MffNipJoNSneNnl+R/+5ISrNOwOU6V1nwgvDZsPS2BGCKbMoUggMvHqL3sQAY7nDSZTyRfI2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766982; c=relaxed/simple;
	bh=xTj6hV2u0GBq41Flpgn3fggvBBiPJk+IObL3IRALJQU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XyjX63U1OQr+ejHa7mC+QMTTAzBylf1VJblV3SGskKB/41pTegUqqzoOzaN97AxGBSoLwtMTFdzs0hI/NblXeK918l1fhhNMSkC3B1l+oS2npxQWr1Fl86nBDTPMe5TLOrSsbbXLpUhLSbvZWDEkQle5ibAZeNP9fv7mOrr40sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hFqXtdee; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8b519e438so5348073a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712766980; x=1713371780; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4fM9WJ0Rd3Z/0g9/JKaFhLLjWLECyZ04GecXr4Pmt64=;
        b=hFqXtdee5Zqej2QgfQ0Qi6H41b1k1BHfENVoqF00O/Aq8OD4V5JKVbjAt7YA+/Vlqn
         25vuAahZf8mtKThKcLaoPAfsOpZ1ZYuf4UZPiYvlqDSAYtXdR0R9j+iBeUSqVlMkU3fs
         CfeY8ew+rmP8MMSIEcccbbnlglmiEgPDNovGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712766980; x=1713371780;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fM9WJ0Rd3Z/0g9/JKaFhLLjWLECyZ04GecXr4Pmt64=;
        b=tLMOEdqanOZJa2hrLGEi+HcZ/fl4NVuqh+xS1qn+Bgp8eKtj5O6u2pLTYZ2jRMAGR5
         PuHnqQqTN/u2lft+CDG7REEtgHJ9bscR3orID2TQeHXWZwJQNqhjHv7B0Wk08Miy8zz9
         P6KQb7QR12ZI89KhfR4wYTIPqWMQsndw0prpLPRMx57CzbqEMZhI/pT3Y385Yuk5OdOz
         WBcs26vBqc48NjGws+QH5TDdp10JpNh3cE89OrjECyX1lWYC1Edb8GwEwG3psFi4eN5Q
         rdOimdsXBVJYvNGY9Hs+TA2vQ7LHgLwqILkNV3E0fngP3iSflnh2s0YeYezBxrZwBOmI
         EFIg==
X-Gm-Message-State: AOJu0Yw/Lg1RFMyGYmwoYPfdEwWyiU7vz2iFiNGjmrNMGECIRx1dZJVm
	CmbVhyjXiO1clj8168SPWVn0hAwbvGyX+lDMTLXqCCebQLl/Z/CW2b814yjiGg==
X-Google-Smtp-Source: AGHT+IFRx9Wu5PEoFfEdC6BbngWDoyMVTVTXhVI3DmiSPUiFROwVcYTt51z4SpQpw6glStOecpveEA==
X-Received: by 2002:a17:90b:89:b0:2a2:9001:94bf with SMTP id bb9-20020a17090b008900b002a2900194bfmr3250080pjb.14.1712766980235;
        Wed, 10 Apr 2024 09:36:20 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f22-20020a17090ace1600b002a2a845868asm1547061pju.57.2024.04.10.09.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:36:19 -0700 (PDT)
Date: Wed, 10 Apr 2024 09:36:18 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [GIT PULL] hardening fixes for v6.9-rc4
Message-ID: <202404100935.3D7CAE6@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these hardening fixes for v6.9-rc4.

Thanks!

-Kees

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.9-rc4

for you to fetch changes up to 9c573cd313433f6c1f7236fe64b9b743500c1628:

  randomize_kstack: Improve entropy diffusion (2024-04-03 14:45:03 -0700)

----------------------------------------------------------------
hardening fixes for v6.9-rc4

- gcc-plugins/stackleak: Avoid .head.text section (Ard Biesheuvel)

- ubsan: fix unused variable warning in test module (Arnd Bergmann)

- Improve entropy diffusion in randomize_kstack

----------------------------------------------------------------
Ard Biesheuvel (1):
      gcc-plugins/stackleak: Avoid .head.text section

Arnd Bergmann (1):
      ubsan: fix unused variable warning in test module

Kees Cook (1):
      randomize_kstack: Improve entropy diffusion

 include/linux/randomize_kstack.h       | 2 +-
 lib/test_ubsan.c                       | 2 +-
 scripts/gcc-plugins/stackleak_plugin.c | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
Kees Cook

