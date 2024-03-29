Return-Path: <linux-kernel+bounces-125523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3FF8927C1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8F91C20F35
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF9113D240;
	Fri, 29 Mar 2024 23:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW17gx2d"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564134B5DA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711754344; cv=none; b=tHyxyXpXaE4bK2EpJ9udiazpp8th3VjiBIispNEFdsPGqDgWRdtn1YOvOp220Wlq3m6OcodW0vd+9cr96i6KOS6qrCaQ1Vu03+9vjtQbG45vmEZbadafTg4GGvZVuNbf3MOo+6crw2g0qHPrsHZUPX8urEF6CAwdYeOxjzVxF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711754344; c=relaxed/simple;
	bh=vnGFST8g/D2/54qEF94dGguSEUSHy9NC6zJgvdLnJag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YIpphg1Z2snGdpl6X9GooneIaKaSOQlV4E4RhZzYo16mMXsApb/mIYTFXkG7Jd3XSveUOh+Bymg8sYK2rNnWoMf52Ym1xPmt8SFFUQoIL3usd7dDmqkW5wxodRQsSeF2mh7/nXwP6sjIp3YGs/lEw23D6VBawnat2iA4wFsr18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW17gx2d; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a47680a806so563791eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711754342; x=1712359142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnGFST8g/D2/54qEF94dGguSEUSHy9NC6zJgvdLnJag=;
        b=GW17gx2d44+c/9GSHNRM0Z+fNJZ3xweh95mTonLAIrZN1PUObIPrwuZtLCDxrTWUFy
         Te0hq754oOXEmF2wD2bJwlzaoDYPN/3VXbYogeJLP/UeqTL8TTCgeAccGtIceCVfyBHn
         7R074c3OXUVIhrNFbSX/JFvW56puOi1Wqzum6EgzZ/wnaQQOoXAu4EuxKDgTcLWv58D1
         97lAYwMa3oYVexf+1sXKBR2tkNJayoxnJuK5MUae22VldT+NtxkoobBFsZbmmnPYkQ/J
         1GAfyKyF60enIRsM3qwhGkbztUHju89Ix5dyey70sjRZ54OLp8Oyu3LKmdrai1APDe3u
         nHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711754342; x=1712359142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnGFST8g/D2/54qEF94dGguSEUSHy9NC6zJgvdLnJag=;
        b=Uyu1uc7S9b7Yb/gSfac+O4Jk3Gpe7JPZUVGd1ubvvuoT3UW7lxQzbnP2otBhdq/bJY
         kNX30m/M0cvK6bTu9++O9FzoTN4itiETeSdz/3DySnNzFhqIJx7Hqeeb2aIYuGCQE2YE
         KacxaQULsAsk5iK9fJvGuzJ9kmOMN31lwhim978FIVUWz8SHLZpRVXn/UHe2dUk4tpO7
         WVPAP5/dFWXngnGLvI3rpKyAZY7IZmwNN41iLmwfPVva5tnf2Zr13r2XuyyezYV4t2Bd
         GCzsJW4e2LzX+QCXRqqyxrIjeJD/oCmU+A7maD3PM2HwEoko2AOatFMk82WClx3P5zI+
         TtHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA8KnbJvt+krcN3z+7Jqy36PBvUinHeCCOWSTRoKS4s/8u1eGoqNNLPewAKoCQTRUOV7mxbhTNnw203KTUg7UrHfi5ypUa4Ub4xQc4
X-Gm-Message-State: AOJu0Yx/A2MbMNZOfT+Yb7F8UV0xg4aShv0EZr5DqtaCijEkdHfmbOcl
	d06IyZQFqdZVaCS9T1O2NDrFcx7uuj5wJyN3Onerl0RuqOcugHGF
X-Google-Smtp-Source: AGHT+IE2db2L9WUF+xM4vQcDoAeeD6O2XDyv0ZurcW/IrEcP8yVCzcBmxiAcZhOdkPb1TwQajv5big==
X-Received: by 2002:a05:6870:9a05:b0:22e:dce:39bc with SMTP id fo5-20020a0568709a0500b0022e0dce39bcmr1557265oab.3.1711754342219;
        Fri, 29 Mar 2024 16:19:02 -0700 (PDT)
Received: from SDF-ThinkCentre-M93p.localdomain (c-76-17-255-148.hsd1.mn.comcast.net. [76.17.255.148])
        by smtp.googlemail.com with ESMTPSA id cm9-20020a05622a250900b004317485a4e9sm2044266qtb.66.2024.03.29.16.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 16:19:01 -0700 (PDT)
From: Shimrra Shai <shimmyshai00@gmail.com>
To: jonathan.cameron@huawei.com
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	max.schwarz@online.de,
	niyas.sait@huawei.com,
	shimmyshai00@gmail.com
Subject: Re: Re: [PATCH 0/0] (proposed?) Add ACPI binding to Rockchip RK3xxx I2C bus
Date: Fri, 29 Mar 2024 18:25:28 -0500
Message-Id: <20240329232528.79332-1-shimmyshai00@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240322103521.00001a12@Huawei.com>
References: <20240322103521.00001a12@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey Jonathan,

I just heard back from the firmware team. Apparently, there is rationale
behind including the clock bindings as part of the _DSD_ - it is because
apparently MS Windows can also run on this platform and it expects those
bindings to be there to configure the clocks on this platform. If they are
changed, it will break that capability, rendering it kind of moot to use
the ACPI boot which is intended to be universal across OSes. (I also wonder
if NetBSD uses the same bindings as well; that OS can boot via ACPI boot
without much issue on this platform.)

Shimrra


