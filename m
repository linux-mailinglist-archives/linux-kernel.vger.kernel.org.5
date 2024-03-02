Return-Path: <linux-kernel+bounces-89526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD5786F192
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17451F221C0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919E92BB00;
	Sat,  2 Mar 2024 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="DhyUhUhw"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D41B22F0A;
	Sat,  2 Mar 2024 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709399170; cv=none; b=UKjsuWztBIDm6WAC0ncIUYJ7+850W9s0AbM5qngtagFJ+avQdzM/MeNSvXbVheIPzCU5WGikelc96yn51e/P7hYEld5o5aYB53UqLQ2t4xTBMMBfSjiofG6PkIMxLOl7sQNS6EsORw2Pt4i7AF0VJxjIQ5ssLr30FK47qWUusxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709399170; c=relaxed/simple;
	bh=v+OJFshByEWAJg/mbIJ9CI0LleTDDqvK0wlNvKIP6ow=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gQOHcwqYAERMwg3bbxarAe4NuToYxNzH9U3xQURa2xy1nwhzi6KzLep4sRBWW7/HHEZpR0lGKsF3kpg6/DgBd2sHi9+gNISP6JVXFgVp+Wc+szw9GqBuSzKAzttC8hpiqqnFhfhXP2moOGCYFIHzwv14bUkKyyFNK2k90bo8eeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=DhyUhUhw; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-365169e0938so8474875ab.0;
        Sat, 02 Mar 2024 09:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709399166; x=1710003966;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3PNucntCeS+UWaFbjqYBQ/khoRyv2O1M6VR2Wkvlm94=;
        b=dkxtYp5WB/Fap/1zVMdqlB+DvoyDRk8OXXuv6t99h5NxHKDdjJxnPCVJXJWCWCH5OH
         nM7MBmCNDOJQJU2bySlFRFu1GdjEu9ILKGu95uUrCUbOA81ls+Dg/8YPnq3q/AgtCKF6
         MvsYk8ld5qYT82S20ZDrnp4kCH9HwGtix/ZwInAX1y3Ykdf0kup2YocfsuJBfYOrqaEQ
         6XNbX/De6nMH11l6E8XHs3Gw8P74DWKH5a6quK1V+haWBM5yRxJRcQqOnaFUwe2q5i97
         dyn91Zd9oto/CBj9jMXqmcybwhMCjbFbQXSlvKkikkHm1tIWfZUIl5dQO0x9KNJMQYPB
         3gmw==
X-Forwarded-Encrypted: i=1; AJvYcCUCp+93l+eYr+6qapcWezbPkcd7Aonqxh6OvuAAEXB4HwBOvGpoxugyhZM8DR422xH7EOTqVwVOuYlNkycqqIvALQRRgI6QKmxhG6CPio0Q0Z5VJ6wwwNUmLXX/moVjTq0gSwKI6iauqkt5wZW1M7IS/3jpHprBvysWX+dGnJrE
X-Gm-Message-State: AOJu0YzNuYFs8vakCnAPlm8E2I/JLbKnpDLUewGK5wF2NLXXyuyQbNE1
	HJqlwxgBC8CmVRNksJP5MqG7btlxuZ4A6zCN/Xd1oncbe9lk7+nj
X-Google-Smtp-Source: AGHT+IH5JzoTTuQEJOxaC3A861Dt7m2ImsX7WjijewxBOr/DU8rRUbuvfEMzv5Ng8kelov0y+94UFA==
X-Received: by 2002:a92:cd81:0:b0:365:102a:ee10 with SMTP id r1-20020a92cd81000000b00365102aee10mr2841784ilb.6.1709399166570;
        Sat, 02 Mar 2024 09:06:06 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id eh28-20020a056638299c00b00474782f85d3sm1394978jab.94.2024.03.02.09.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 09:06:06 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709399164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3PNucntCeS+UWaFbjqYBQ/khoRyv2O1M6VR2Wkvlm94=;
	b=DhyUhUhwTcosKpYaAuu5glZlfY2m43JsmEa3/P1kUsbg7MxfclQ9xfBB4S2KfN/Qcu9zue
	Z1FEHpuYZneWF/GlyQB8LpBeB0oH5Qp81GqMdWnf+W3wuwjxvfRkf0ooUaYl4uLATMWagZ
	MLP5IzQl7QJizUm//qQSI21OdIPTFFMSFuLHGmsFOgNq5lhDYEJxnHMgSimTJY4+v1zj22
	s4O/xLhpdK3EOQEWPzLXmwKwr4aNP03AqonMhw92/Q9BPUTUQOfJL75rYPD7y3tjRUueQc
	v2wbNILmS5AYJAKyNM5HvQNCuWSUrHCa/UQdm7R8VrzXIAYEhn+mweNJHQ+t0g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH net-next 0/6] net: constify struct class usage
Date: Sat, 02 Mar 2024 14:05:56 -0300
Message-Id: <20240302-class_cleanup-net-next-v1-0-8fa378595b93@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHRc42UC/zWMUQqAIBAFrxL7naAWBV0lIkzXWhALtyKI7p4Ef
 czHwLx3A2MiZOiKGxKexLTGLKoswC4mzijIZQctdS0rqYUNhnm0AU08NhFxz1y7wFq5yRnfetl
 AHm8JPV3fcQ9/BcPzvK+a9/9yAAAA
To: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=v+OJFshByEWAJg/mbIJ9CI0LleTDDqvK0wlNvKIP6ow=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl41x6FlWw4+u1HFoujEMvnrq0vur99Hv0UlBoj
 sgDJ0RwFSuJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeNcegAKCRDJC4p8Y4ZY
 pi8uEACjiEmqqtlH3qdb7MUNb1AmtLNLWqY57h2Ehu2KYh/0ESo8l2LXZSRpiWtxty2kDlE0C7p
 G1aazjzAe1GHj9UVviKcsbW30AIhZdcUIkJA5eX9/ZQ5ZphWK/fI6l26fYKvREF1Roh3RqCfUeS
 Qhpb6EQB7KXkMu+IKqQcEVqDMiIv22KmrqUQoXusiKJp6TFPLqXdkwo9OZp4Sh4IQdwbHvtSOKK
 WmhN6VxCWDev5fTCaVqjxEzeurQjDSdy388rnJmZLYgRh3i/Nk2wbL3iNoHoSbf4vCgdxRe1M3R
 6uJrzVfPf3CH5CYmLymRtgjZogy1dRKHKhhhW3ay8RedaLJcn2in7+KwnJR/sukyDBZjWyouGsC
 co2n0u1K0fdbw3Whtn6nN40jyZim7MRwt2n7l3eInXRHC9qMVzKMqhiM6NclyhWTzZLdNXmKg63
 amS7XsX7/0EelJraI9vlJPnI0UiIodcgERk8y1PWbWcd8gQwJqtPJKx1z7kHpPqT+x/SA57D3Bo
 3AptIMStSHEhLiNyARxy7gueOHlamBSuiGmKhEugsShU5+Of/ZOe7cD/6yCKCDHosI+GNk2UV+m
 N1ogsM88SkyJfO+Ii1TeZzWP50fCMGRlIA7VZDI41BTFF3w8HO9n+kYbh0GazEa1x8RWAf976/W
 0vyc2mZQYtiVKlg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This is a simple and straight forward cleanup series that aims to make the
class structures in net constant. This has been possible since 2023 [1].

[1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Ricardo B. Marliere (6):
      net: hns: make hnae_class constant
      net: wan: framer: make framer_class constant
      net: ppp: make ppp_class constant
      net: wwan: hwsim: make wwan_hwsim_class constant
      net: wwan: core: make wwan_class constant
      nfc: core: make nfc_class constant

 drivers/net/ethernet/hisilicon/hns/hnae.c | 13 +++++++------
 drivers/net/ppp/ppp_generic.c             | 18 +++++++++---------
 drivers/net/wan/framer/framer-core.c      | 21 +++++++++------------
 drivers/net/wwan/wwan_core.c              | 30 +++++++++++++++---------------
 drivers/net/wwan/wwan_hwsim.c             | 16 ++++++++--------
 include/net/nfc/nfc.h                     |  2 +-
 net/nfc/core.c                            |  2 +-
 7 files changed, 50 insertions(+), 52 deletions(-)
---
base-commit: e960825709330cb199d209740326cec37e8c419d
change-id: 20240302-class_cleanup-net-next-e41dbdaf7f06

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


