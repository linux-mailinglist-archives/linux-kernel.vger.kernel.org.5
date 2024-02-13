Return-Path: <linux-kernel+bounces-64352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F230853D61
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF67B29373
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B088A627EA;
	Tue, 13 Feb 2024 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfcQ9x8l"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444FE626A5;
	Tue, 13 Feb 2024 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860420; cv=none; b=pdDQvsy3V40H1quReCC3SiKF6lm1F/wshrkXTgYTPja+qzmy/OWFRc1P8ge6W4kQ7cW0vsJlma3BELDA/f9GWlW85DI4qJoX1T6snC1TQ5SE5gWK+fzu8QYgZGtoegrQYNH5o84lEwdxNC6ntVOF49FFGdEXfcPhY4rZDziCwls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860420; c=relaxed/simple;
	bh=Xlt6sMMKAUm7IbZRBGhxEDcRLpN3TDT3XNkJuoLuK4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oeq175g+aQdGX8HAbSIuMR4lRmEIjkBBzAFzbB1qelMjezHuBkPGBTJxJG+Rx9vhYwE+tVbmfC49uh5pa0rGbnhcm31IPYd2lT6b44i7vwS3hWJJ0whc177lp5DsZDogn1xfxrt7BGOwmo16DVCC9GblHH9ZG71NV35LjZ7w0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfcQ9x8l; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-562131bb958so638291a12.2;
        Tue, 13 Feb 2024 13:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707860416; x=1708465216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABA/+6oxHumH7163VNUvqNT1eTr+ehROcpiaVQm4GRM=;
        b=kfcQ9x8lSchRiS52FwWp1Gagui0+aS8XRH6rK93zICTcf1VUv9Tkx60KEnPk3/kxIq
         9BbDjBKfY7xWwxohXahj/IaTZqNCENEyt6L+ILwHtozXX7gWdzr1aMY8EPqhgpi+RI4h
         hKdMv+6n7/V4BFTGo3+Z3JV00ZBKAF/Bo3PMe0U+3FZStyaM4q5rvqu0kXWlmZiQGQfG
         Dy7hEZ+WiddvC08SeeKHcGQCErmRkjr8BitoU+PpMb2T3Q60Kn/6Kxb7fiAU2F0+2UCQ
         mNMxH+5ATR+KIa2vRKHuZp21ArKIo3g0KTqqUQAVT+NqJjHGVmYvp3mTAaia81r50i/t
         oQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860416; x=1708465216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABA/+6oxHumH7163VNUvqNT1eTr+ehROcpiaVQm4GRM=;
        b=CBqKt8M+yPYnXyvcC9UPSglZ2JMo/th2F/zGfm0COX79E3HQABL+ns2f054jHttyMz
         QSByYYnweW/tOYb55n0prgoPOlkvHLTmER6jg/0RRMHP1CYnI5Cm0/TWRBQsxg0JrzvQ
         wiWvkezKUk/9uK77yMG4QM8wGl7JrhoKmoQrS1fMzRkvxBtattdWlHXZrBK3y6wC+3n/
         unq4F2wNsU4ivQPq0pmpI1gfNn4IzRMTis7Knd1wonGBjxKnS57i3peS0VAlUtVPmkGo
         px7TqhCJWap3TSVKhwwQo6MEWJQDxf9GTfKRUKEQxraPSaV5RqUK5MnH6y93VS7brXZZ
         H/9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYxSfiV1t2iXkHC3sJ7LQMixE1aCc5PeWuMaTMI+048f7aPNms3uv0froa7EgzwKFNgOuDgDLVEFeF3slJlHgK7JfqL8LcByq8LU4hPsZ8OK8yHmm1EiQIIkAwxiWTsKjxYyVV
X-Gm-Message-State: AOJu0YwYoDSnzk7+4q3h3uR4dZNeqZTA68CgMeMQxtu901+GrcTLBQTS
	qUDy83mETMjJuH5+j2/anzEA91HivENetpsqc4VoqM1ugzMgqVMh
X-Google-Smtp-Source: AGHT+IFzlEkF30+ITzXFlyZox4AktOmmGvYslinHBs0N6IAogbMuqJkmq4ru3AkyVSMwXOpOZ+MPpA==
X-Received: by 2002:aa7:c90b:0:b0:560:b758:5e2d with SMTP id b11-20020aa7c90b000000b00560b7585e2dmr680585edt.27.1707860416556;
        Tue, 13 Feb 2024 13:40:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHOkwuSj13xM/kFQBSiTDW/L5eZa2YUoY1+/sthxs8AQTHQ8TMJlJVjnqrG7HbI7QzRnioeew1Lu9DWLI3Ha4LqD/9Sskw7MgqEq+8WsKH/SCeuqFZhUpm03WqRF7qIrP4zVv7DiKouabV7rqsMV+ikGObSw7P3Y9H59pcsRb5m8WJfIdrReIK2Ffby0oCOgaGiSTI549itD+YefgKkQnThn+O1gIrxYAqGMMg5KBH8AoRWf7q70IH3ggHrwdlS+T3yTKQnFxd4T3O4RJGLTUWd0FOVqFKfzlxugMByJCuIlcd2IR65/EcWwHa7xwASP79MiYNiv2NgAlKl8TV3ENNV80=
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id k23-20020a05640212d700b005612987a525sm4003913edx.89.2024.02.13.13.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:40:16 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 net-next 02/14] net: phy: Support 100/1000BT1 linkmode advertisements
Date: Tue, 13 Feb 2024 22:39:41 +0100
Message-Id: <20240213213955.178762-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213213955.178762-1-dima.fedrau@gmail.com>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend helper functions mii_t1_adv_m_mod_linkmode_t and
linkmode_adv_to_mii_t1_adv_m_t to support 100BT1 and 1000BT1 linkmode
advertisements.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 include/linux/mdio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 79ceee3c8673..ecd21acc7eed 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -373,6 +373,10 @@ static inline void mii_t1_adv_m_mod_linkmode_t(unsigned long *advertising, u32 l
 {
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
 			 advertising, lpa & MDIO_AN_T1_ADV_M_B10L);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+			 advertising, lpa & MDIO_AN_T1_ADV_M_100BT1);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT1_Full_BIT,
+			 advertising, lpa & MDIO_AN_T1_ADV_M_1000BT1);
 }
 
 /**
@@ -409,6 +413,10 @@ static inline u32 linkmode_adv_to_mii_t1_adv_m_t(unsigned long *advertising)
 
 	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT, advertising))
 		result |= MDIO_AN_T1_ADV_M_B10L;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT, advertising))
+		result |= MDIO_AN_T1_ADV_M_100BT1;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT1_Full_BIT, advertising))
+		result |= MDIO_AN_T1_ADV_M_1000BT1;
 
 	return result;
 }
-- 
2.39.2


