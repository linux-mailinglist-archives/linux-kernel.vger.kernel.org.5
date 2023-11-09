Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ADA7E664C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbjKIJKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjKIJKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:10:00 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272F8210E;
        Thu,  9 Nov 2023 01:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=V1vx6w7oX9bnGBGIeKU2lCuTws8fL7Xot+rBe/Vo1dY=;
        t=1699520998; x=1700730598; b=AB2fXZkoM0GnnBQfbH+nrksAqS3SiGKA08JKCytsYtRHZdV
        rBt9DXNBj4QcOf9Ymfz6EL8M8YL4xYayJ7GwZeq2Fq6yzGOHNWmFmNVjSauS7LOWgMlgUT1FpcLKF
        s4/lv1q0+znbQKZDCOQQ1uFet4DKTswAn1PAmF2N520YQs4+lE3ry+SSbjJSjaub1/lUNS3FAB30n
        A9Di74cEUBYyfpYnuzMd608gklRsv1l3pUm3q3r5tNzSi/v37QK4LMTdp23yJApYSB0yNZLRzNRF+
        R4j/IKMx5uAwgIF+FqlTRPaTfVxAcKz7HhBzCOuH8jEB2iRYk2ZDcnTcQn14ZkXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r112w-00000001gJ3-3sdl;
        Thu, 09 Nov 2023 10:09:55 +0100
Message-ID: <5a5203915a94a0299131d3e03d132c40bd98dee6.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: Fix warning by adding dependency on DMI
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sunil V L <sunilvl@ventanamicro.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        kernel test robot <lkp@intel.com>
Date:   Thu, 09 Nov 2023 10:09:53 +0100
In-Reply-To: <20231109054027.2870124-1-sunilvl@ventanamicro.com>
References: <20231109054027.2870124-1-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-09 at 11:10 +0530, Sunil V L wrote:
> This driver currently assumes CONFIG_DMI is enabled along with ACPI.
> This may not be true. Due to this, the kernel test bot reports new
> warning like below for RISC-V allyesconfig builds.
>=20
> > > drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1190:25:
> warning: '%s' directive argument is null [-Wformat-overflow=3D]
>=20
> 1190 | "System vendor '%s' is not in the approved list, disabling PPAG.\n=
",
>=20
> Fix the warning by adding dependency on CONFIG_DMI.
>=20

Not sure that's the right fix - why not put checks in the code there?

Is it just a build warning?

maybe

-dmi_get_system_info(DMI_SYS_VENDOR)
+dmi_get_system_info(DMI_SYS_VENDOR) ?: "<unknown>"

johannes
