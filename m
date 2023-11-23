Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128EE7F663F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345669AbjKWS2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWS2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:28:51 -0500
X-Greylist: delayed 462 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Nov 2023 10:28:50 PST
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE161A4;
        Thu, 23 Nov 2023 10:28:50 -0800 (PST)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id F10C815A4FCE;
        Thu, 23 Nov 2023 19:21:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1700763661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=gec4TYlOPlj2h/XodVWwhNNB/vj9qHRQL+92P5jpQ8w=;
        b=OHpF74djNa3mrM0hW10/iktp8ZPnXytSFGpFjsV6W4WLkrrgwOyuiwptK8+sbB5Cn1Wp4k
        661CPW2YoWCsrGgapRGj/zV/PBxM5aX0iof5B3c3JcjkhHlqPNDsI3aFWM2Id5xOpG5/uY
        Ix7QgDqgGxbff+D8o6ZuuApeethjsvk=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Petr Tesarik <petr@tesarici.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [REGRESSION] USB ports do not work after suspend/resume cycle with v6.6.2
Date:   Thu, 23 Nov 2023 19:20:46 +0100
Message-ID: <5993222.lOV4Wx5bFT@natalenko.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4877866.31r3eYUQgx";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4877866.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Date: Thu, 23 Nov 2023 19:20:46 +0100
Message-ID: <5993222.lOV4Wx5bFT@natalenko.name>
MIME-Version: 1.0

Hello.

Since v6.6.2 kernel release I'm experiencing a regression with regard to USB ports behaviour after a suspend/resume cycle.

If a USB port is empty before suspending, after resuming the machine the port doesn't work. After a device insertion there's no reaction in the kernel log whatsoever, although I do see that the device gets powered up physically. If the machine is suspended with a device inserted into the USB port, the port works fine after resume.

This is an AMD-based machine with hci version 0x110 reported. As per the changelog between v6.6.1 and v6.6.2, 603 commits were backported into v6.6.2, and one of the commits was as follows:

$ git log --oneline v6.6.1..v6.6.2 -- drivers/usb/host/xhci-pci.c
14a51fa544225 xhci: Loosen RPM as default policy to cover for AMD xHC 1.1

It seems that this commit explicitly enables runtime PM specifically for my platform. As per dmesg:

v6.6.1: quirks 0x0000000000000410
v6.6.2: quirks 0x0000000200000410

Here, bit 33 gets set, which, as expected, corresponds to:

drivers/usb/host/xhci.h
1895:#define XHCI_DEFAULT_PM_RUNTIME_ALLOW      BIT_ULL(33)

This commit is backported from the upstream commit 4baf12181509, which is one of 16 commits of the following series named "xhci features":

https://lore.kernel.org/all/20231019102924.2797346-1-mathias.nyman@linux.intel.com/

It appears that there was another commit in this series, also from Basavaraj (in Cc), a5d6264b638e, which was not picked for v6.6.2, but which stated the following:

	Use the low-power states of the underlying platform to enable runtime PM.
	If the platform doesn't support runtime D3, then enabling default RPM will
	result in the controller malfunctioning, as in the case of hotplug devices
	not being detected because of a failed interrupt generation.

It felt like this was exactly my case. So, I've conducted two tests:

1. Reverted 14a51fa544225 from v6.6.2. With this revert the USB ports started to work fine, just as they did in v6.6.1.
2. Left 14a51fa544225 in place, but also applied upstream a5d6264b638e on top of v6.6.2. With this patch added the USB ports also work after a suspend/resume cycle.

This runtime PM enablement did also impact my AX200 Bluetooth device, resulting in long delays before headphones/speaker can connect, but I've solved this with btusb.enable_autosuspend=N. I think this has nothing to do with the original issue, and I'm OK with this workaround unless someone has got a different idea.

With that, please consider either reverting 14a51fa544225 from the stable kernel, or applying a5d6264b638e in addition to it. Given the mainline kernel has got both of them, I'm in favour of applying additional commit to the stable kernel.

I'm also Cc'ing all the people from our Mastodon discussion where I initially complained about the issue as well as about stable kernel branch stability:

https://activitypub.natalenko.name/@oleksandr/statuses/01HFRXBYWMXF9G4KYPE3XHH0S8

I'm not going to expand more on that in this email, especially given Greg indicated he read the conversation, but I'm open to continuing this discussion as I still think that current workflow brings visible issues to ordinary users, and hence some adjustments should be made.

Thank you.

-- 
Oleksandr Natalenko (post-factum)
--nextPart4877866.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmVfl/4ACgkQil/iNcg8
M0ulrQ//Xt84JG6lXBE8QmL1g5+ySG1xHeSN6zDDznT4ZIFG9MdrIOH4zxZc02Vi
lzSkLMkbq0lyZnR4wCU8dsUorDwS5c6SCVQBtRATkJeozDR0IYJBD3uE/JgR2gKn
PyIBS7ntQfykYOREBlX3BSCteHXRLDxGP6UsRq7EyW8Xv75BehI1b95xq0Rn/Qvi
4TYrUFJ/sfEZho7yefAAuAmS40l6XaBYjr1xSd0aRfILZ7uf9+onSHpFEjmtzGyj
22LkxYkEgzcECJey0PLL9zyHnvwkdj3tM5u3ZZdABsSB4FsVETpeqxWELdAnfzN5
PCVuNDk3PAUiNPW2KwI88eyZJRovjiIHdsudSshdx/Uh/bojqFt6f6i+ttjcV+G9
eLjfH8EM5p0+11VlcTensk12o/2p7tqRL8EmIjvNb0OuaAd6D5ufJZYFr1q5Q9BU
nDHM2Ls6UfzK7OKU1QldFF42LqZBvi6TQEKvF+XsJYGDaSPnYe4gsmDQKudWt0qO
J+X/WlizA1mAifYEsHpTQKex6wGWnLHU1TSjct/cNAEW1SASbw/Kv11xLOIgB4z+
qZwJe7u/aqXwWNmPK9qMKWrNm4IhJB8KjUO95bwAMS5fAl8DhfksB/TTBukXciI9
e3I/AGML88xEqrFGlvejz7ONMuJDudSRxNMax/1zgDBc64FOK5E=
=uQfP
-----END PGP SIGNATURE-----

--nextPart4877866.31r3eYUQgx--



