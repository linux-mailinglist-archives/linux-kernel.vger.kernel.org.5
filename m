Return-Path: <linux-kernel+bounces-4579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC108817F93
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D710282184
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926103FDD;
	Tue, 19 Dec 2023 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="KDGx26C2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27011187F;
	Tue, 19 Dec 2023 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: festevam@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id DC18286EF3;
	Tue, 19 Dec 2023 03:10:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1702951846;
	bh=o0/an4JLoBy6ZGiSNhJfIYsgD5HBecZioCSamrEdvKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KDGx26C2iWbstqsg1stE34+Q/3S3yBZNuK9b5YgBNMqzFsy4oCnuJncQE+VoFCpE4
	 Ff7RBASnXU6h2UCSKa9HMZquGbHf05xmn6JfIQcsVaigeTumwCbxezkp5bIpm0X/E1
	 kn6uPo9+nogDgrGMmhOu949PI9JcK5tvZzQfUkTrR+vvugPV4yTMzfTFcfJpYiCp29
	 QOISXc1o7HIx1VO6Z9RVthgBOQjrtfq0FgGfpQOiouTXTBoqB7Nx0odJwfynesdLMw
	 7vvnZaHMiSvzJTT49GzoV1PqQlTj58WCyR+XdISkM3IBufEj2WtKVZAez3C88hqs3U
	 4AqXX7RQbeVgg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Dec 2023 23:10:45 -0300
From: Fabio Estevam <festevam@denx.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
 <rui.zhang@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the thermal tree
In-Reply-To: <20231219103457.4e034e9a@canb.auug.org.au>
References: <20231219103457.4e034e9a@canb.auug.org.au>
Message-ID: <68012fb93e0057f62c03a5d9b01237c4@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Stephen,

On 18/12/2023 20:34, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the thermal tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: modpost: "__hw_protection_shutdown"
> [drivers/platform/chrome/cros_ec_lpcs.ko] undefined!
> 
> Caused by commit
> 
>   726edaad90f6 ("thermal/core: Prepare for introduction of thermal 
> reboot")

Thanks for reporting.

Daniel,

Could you please squash the following fix to the commit above?

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 07eb6537ed8b..f814568525f1 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1002,6 +1002,7 @@ void __hw_protection_shutdown(const char *reason, 
int ms_until_forced, bool shut
         if (shutdown)
                 orderly_poweroff(true);
  }
+EXPORT_SYMBOL_GPL(__hw_protection_shutdown);

  static int __init reboot_setup(char *str)
  {

x86_64 allmodconfig builds successfully with this change.


Thanks,

Fabio Estevam

