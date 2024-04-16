Return-Path: <linux-kernel+bounces-147298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF778A7226
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE761C20F39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13D2132C15;
	Tue, 16 Apr 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LQwJdmJG"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763521F956
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288149; cv=none; b=oX8SXqWkVXjvy8kFqcDTsOtDQFHsZKh+eGWT/VZ6x+BB19TaHlUU0osunPZXdFkrTsXBwelA9p9AbLy5A3urNULp6zyGsd6La8DoFFAzIQuE5xt8hNqhto8tRPqJcH/QDQHyoF2eyqtYVpUk1Jif7bSM2y4CiERAc4i71Ypw+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288149; c=relaxed/simple;
	bh=8Ev1y/XXZzN4a3sO8gJbHnCK2YucAiCvJ+L9Yia1sYc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=UYatdAp/Tu1nUBcwRMrFRTf5hiOP1aBSxc5JrtNlwVOpFPOdtvARQXaN6sBWQEiHvRlIyrtd30p9X/M9f6FQZ7Yg+qRcao6hTrxhBiTSgB9SO+d59xXtyK3cvrFUTzprUBsHAnhZ3krXuMLtZZwznJmogwSmtLFJuTBP4vMCWJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LQwJdmJG; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78ecd752a7cso284751685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713288146; x=1713892946; darn=vger.kernel.org;
        h=autocrypt:to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qGMkcJRf4HLQyYc5ZKDVB15+tfpBYDO/0grdJ5fWW2s=;
        b=LQwJdmJGG0xu6EoArCZBqAKEI71R6W1wgj0/qGWQbPB/Gt2ZB+z6K6aHOtSbdHpoEl
         rSPenTio+yLxjJ1gBgGJ3zUiMUcltXOfJ8+9M/uxJGlZS4miqcDh9WWf7SN/zOwN3B7p
         5Ifc1jDEl1rqJTlQfZ+JQiYkEEm8J21K17BEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713288146; x=1713892946;
        h=autocrypt:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGMkcJRf4HLQyYc5ZKDVB15+tfpBYDO/0grdJ5fWW2s=;
        b=v+Tk9e2SHc2MNFeHg81GaelcK3VbKBiJs3CHvOSWq5fu/hLYi95IA8yUPinoRM8UGh
         ap3lBqFrb+uI/fVPbgtT97JunOH1Vxc4iL3sSY0JPDsdMlGFWmKhK/v0MCPW8zYjHMqO
         n6TsuttaA4ga8Fqg02o7WL9hhYFfWwL2uIHLt4guVD/XfExK9H7nXqLLnbtYeWJbmrjL
         XbB8fE90Ip2Y7xFCH8Diot1BY0530Kog9Rfqis635EdWuI8f88B1FJRnyzIAF/zKVMHY
         Enx6iLIN41EElyEcO75qRjxdcsjLN5VVXNVWb/tE07AT7A9V9xXa1QbnV93v6XlOay6J
         KkMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBGhNZ/dM+7PCsiEvoXRRo6VyPJHiFCDpcEaIi7w8pM9Ti7Jz3pK3bMy+OOZQ/c5kEGjDQ476Tp4/BJtn12rIcPdsJ6U1cjpHH8Xud
X-Gm-Message-State: AOJu0YxCmSfct3lZRISZWERIj3sDDrStOqYJBtzG/vuNOycyE8MMqwxH
	2m47vTjNKDdGeavobmlVmC3uKCDpwK4SGduwf/cgQvK21iD+NnkebNkPZSXeaQcqSfvv9K9HxFs
	=
X-Google-Smtp-Source: AGHT+IF1uGNLU2/+iF6W0RNvoh9AcJr+EBT3jbTslnX0hRgDP/rKb/8IEtM/MZTl4r05Pn3n4zEHFw==
X-Received: by 2002:a05:620a:841b:b0:78e:ddf8:da04 with SMTP id pc27-20020a05620a841b00b0078eddf8da04mr8250282qkn.68.1713288146302;
        Tue, 16 Apr 2024 10:22:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a19-20020a05620a439300b0078d6ef5fd07sm7617592qkp.50.2024.04.16.10.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 10:22:25 -0700 (PDT)
Message-ID: <ea330927-2a8d-4026-a6f1-d418a916d19c@broadcom.com>
Date: Tue, 16 Apr 2024 10:22:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Issue with "kbuild: create a list of all built DTB files"
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000622d7f061639fbcd"

--000000000000622d7f061639fbcd
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Masahiro,

Sorry about the late report, commit 
24507871c3c6ae4f6b460b016da7ff434cd34149 ("kbuild: create a list of all 
built DTB files") is breaking the build when we are doing a rsync of the 
Linux sources into a build directory, which is how buildroot works when 
doing a source directory override.

This does not happen when doing a build from the git directory 
containing the sources, and I cannot find a missing $(obj) reference, so 
I am left wondering what I am missing here. The build error looks like this:

cat: arch/arm64/boot/dts/actions/dtbs-list: No such file or directory
host-make[3]: *** [scripts/Makefile.build:423: 
arch/arm64/boot/dts/dtbs-list] Error 1
host-make[3]: *** Deleting file 'arch/arm64/boot/dts/dtbs-list'
host-make[2]: *** [Makefile:1394: dtbs] Error 2
host-make[2]: *** Waiting for unfinished jobs....

running with verbose, we can see the rule not generating an empty file 
at all:

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=scripts/dtc
/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=scripts
/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts need-dtbslist=1
/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=scripts/genksyms \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/actions \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/allwinner \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/altera \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/amazon \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/tools kapi
/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/amd \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/amlogic \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/apm \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/apple \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/arm \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/bitmain \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/broadcom \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/cavium \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/exynos \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/freescale \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/hisilicon \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/intel \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/lg \
need-builtin= \
need-modorder= \

# GEN     arch/arm64/include/generated/asm/cpucap-defs.h
   mkdir -p arch/arm64/include/generated/asm/; awk -f 
arch/arm64/tools/gen-cpucaps.awk arch/arm64/tools/cpucaps > 
arch/arm64/include/generated/asm/cpucap-defs.h
/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/marvell \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/mediatek \
need-builtin= \
need-modorder= \

# GEN     arch/arm64/include/generated/asm/sysreg-defs.h
   mkdir -p arch/arm64/include/generated/asm/; awk -f 
arch/arm64/tools/gen-sysreg.awk arch/arm64/tools/sysreg > 
arch/arm64/include/generated/asm/sysreg-defs.h
/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/microchip \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/broadcom/bcmbca \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/nuvoton \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/broadcom/northstar2 \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/exynos/google \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/nvidia \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/broadcom/stingray \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/qcom \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/realtek \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/renesas \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/rockchip \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/socionext \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/sprd \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/st \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/synaptics \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/tesla \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/ti \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/toshiba \
need-builtin= \
need-modorder= \

/home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f 
/scripts/Makefile.build obj=arch/arm64/boot/dts/xilinx \
need-builtin= \
need-modorder= \

# cmd_gen_order arch/arm64/boot/dts/dtbs-list
   {   cat arch/arm64/boot/dts/actions/dtbs-list;   cat 
arch/arm64/boot/dts/allwinner/dtbs-list;   cat 
arch/arm64/boot/dts/altera/dtbs-list;   cat 
arch/arm64/boot/dts/amazon/dtbs-list;   cat 
arch/arm64/boot/dts/amd/dtbs-list;   cat 
arch/arm64/boot/dts/amlogic/dtbs-list;   cat 
arch/arm64/boot/dts/apm/dtbs-list;   cat 
arch/arm64/boot/dts/apple/dtbs-list;   cat 
arch/arm64/boot/dts/arm/dtbs-list;   cat 
arch/arm64/boot/dts/bitmain/dtbs-list;   cat 
arch/arm64/boot/dts/broadcom/dtbs-list;   cat 
arch/arm64/boot/dts/cavium/dtbs-list;   cat 
arch/arm64/boot/dts/exynos/dtbs-list;   cat 
arch/arm64/boot/dts/freescale/dtbs-list;   cat 
arch/arm64/boot/dts/hisilicon/dtbs-list;   cat 
arch/arm64/boot/dts/intel/dtbs-list;   cat 
arch/arm64/boot/dts/lg/dtbs-list;   cat 
arch/arm64/boot/dts/marvell/dtbs-list;   cat 
arch/arm64/boot/dts/mediatek/dtbs-list;   cat 
arch/arm64/boot/dts/microchip/dtbs-list;   cat 
arch/arm64/boot/dts/nuvoton/dtbs-list;   cat 
arch/arm64/boot/dts/nvidia/dtbs-list;   cat 
arch/arm64/boot/dts/qcom/dtbs-list;   cat 
arch/arm64/boot/dts/realtek/dtbs-list;   cat 
arch/arm64/boot/dts/renesas/dtbs-list;   cat 
arch/arm64/boot/dts/rockchip/dtbs-list;   cat 
arch/arm64/boot/dts/socionext/dtbs-list;   cat 
arch/arm64/boot/dts/sprd/dtbs-list;   cat 
arch/arm64/boot/dts/st/dtbs-list;   cat 
arch/arm64/boot/dts/synaptics/dtbs-list;   cat 
arch/arm64/boot/dts/tesla/dtbs-list;   cat 
arch/arm64/boot/dts/ti/dtbs-list;   cat 
arch/arm64/boot/dts/toshiba/dtbs-list;   cat 
arch/arm64/boot/dts/xilinx/dtbs-list; :; } > arch/arm64/boot/dts/dtbs-list
cat: arch/arm64/boot/dts/actions/dtbs-list: No such file or directory
host-make[3]: *** [scripts/Makefile.build:423: 
arch/arm64/boot/dts/dtbs-list] Error 1
host-make[3]: *** Deleting file 'arch/arm64/boot/dts/dtbs-list'
host-make[2]: *** [Makefile:1394: dtbs] Error 2
host-make[2]: *** Waiting for unfinished jobs....
make[1]: *** [package/pkg-generic.mk:293: 
/home/fainelli/work/buildroot/output/arm64/build/linux-custom/.stamp_built] 
Error 2
make: *** [Makefile:27: _all] Error 2

Buildroot builds its own GNU Make version 4.4.1.

Any clues what might be going on? My defconfig is such that only 
CONFIG_ARCH_BRCMSTB is enabled, and there are essentially no .dtbs file 
that will be generated.

Thanks!
-- 
Florian

--000000000000622d7f061639fbcd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDnfufE0+kG6ZV5V
pEmIWMFfaJgJHR6gZndbQmvAFRCHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDQxNjE3MjIyNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAifKEhRJV0auRCbtOUD2x2I7WYSF8QmAcT
ibT3dBRxZ3XGwYqqCImF5kbwjVPpeh7FIFUSGKwKV4ViSb6+uZxjDFqc410m1I4iNFGUUYhks7IY
xsm1+ihLD8yQNwy/yHz7Oc0VAZ80kGkNbzktejyWxYuaP3Us4RHuNxT1E4VVZngLQwsxRzJiTHls
OBD+VJGQHRtqJg13NOmCsGkEC3UxHU3733QLqJIlrz/p2bN4R9VMs1G0RYipzFvfL1X+gE8rD4VD
Cx/WoPKfyvNYnPyk8W9sJyCASHrcopUGiGfa3hBPrl/8MoYW7ZBGh1NXHhXu1oxU6hU2S91ghyrg
dJwu
--000000000000622d7f061639fbcd--

