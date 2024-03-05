Return-Path: <linux-kernel+bounces-92932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ED1872849
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C6D1C281EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74636128374;
	Tue,  5 Mar 2024 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="oPx5vjQJ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F78127B70;
	Tue,  5 Mar 2024 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669100; cv=none; b=BVzOlQ0jcqO2rin/tjsTk03YrcdfM/IGoxd7qzVUVsXtp9Mc5pAjMMqcyknFNa2vjfyZlAOy+crwnTqWjeOdLPk0bIuUN0S47v8oJ1NCp+SzfXyIrzJIuETw5XgdIJ0xnnatkVjIIE7gZ34ChvA8kXGMD+Nvk2RQXMOggXXOd4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669100; c=relaxed/simple;
	bh=93s7wGp3C6SdWhWiiV88Jt7u2fX7AdL7lbagzctieg4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BoK1/zYlAjx5RYP5mPYd1/mqYSpxCPszG0M3JyKsg1E3N3ik1PP/Mo3zhhjI4vGRvAt1xq1GQMdkQ/NPXYZSNA/jriZ0HxaUSfAfIXCqUCQ7iemAls4qae5WLHijuEQHOaPsMC+8nvcCMU/sC8QWeA17fdUpDh+O6SRYwXUjOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=oPx5vjQJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dcafff3c50so51989105ad.0;
        Tue, 05 Mar 2024 12:04:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709669098; x=1710273898;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W1Yz5ZxMoGNX+s/VkaNIUxU/ikBjtAUgjoroveWCNXU=;
        b=JwmcqFA7HRTA+yCxdlTD3D2KTALVaHiFqtHiZ8aGOJyRIGDt20FgB5zSUXcgkpPLB2
         jYxSDF7/Wh6XICnHRUmwDAoBthp9u7psgXzd472wKM+DZCYe3aCePGH/eL6GHD44fkYM
         uRTp4MGllYHjjscdxlkSUpR9QJ4PEmcQuBY2njahxQjRtq0XDzUDh/ZDloZ4ZeoyKOo7
         hoY5xfpDgUDa2/vXngbiYbj4a00TZeFh/Vu18sFz29Afzvsqm1103E87chOsgP3eYncm
         RKwVXdqJnPzWPiS8iy2ROj1M4NpkN+KTxbM+aR/BcE1pT5ZcQPtnPbPkQ9apf6ee3TA0
         T07A==
X-Forwarded-Encrypted: i=1; AJvYcCVvXujMWu1AaanS2NW0gPwp5EbHTiEHxaqc4TofVihjli4GrS9zvb6zvybDqjU6uQzUn7Mxcl3M/DBnONkSPEZS41IQ45pEHirK3f88QFFp4jktUkjdZuLGBzpF8zPrUCBXN/3Z
X-Gm-Message-State: AOJu0YwXdE4Ez/240x+b2DgcK5aip6AsHQbqmRLun2djP/VmorwVIxdk
	nmNtTbjxTyYlZQAyp6I+C3wQUnFBJQ53K4niKCbMeRi0SCQ4vPgi
X-Google-Smtp-Source: AGHT+IF+Y/w153UChF9kEhCDt8KnDSdEUrMgFMUF/fmIXh07geGvM5TPL/KxQlLN4hY8KpWn9Sdn0Q==
X-Received: by 2002:a17:902:a503:b0:1dc:c59d:5dde with SMTP id s3-20020a170902a50300b001dcc59d5ddemr3054938plq.59.1709669097619;
        Tue, 05 Mar 2024 12:04:57 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id j6-20020a170903024600b001d8f81ecea1sm10978693plh.172.2024.03.05.12.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 12:04:57 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709669095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W1Yz5ZxMoGNX+s/VkaNIUxU/ikBjtAUgjoroveWCNXU=;
	b=oPx5vjQJ6Qq+JYBCc+xene6OV1txaEM4BRNL6u6hzlJspRRqw5ET5t1B/uqYeGbp7COWrG
	ecAAKJcOz6ZTareULKVrXxaCNUC8kUhBAyQHyl9VpzwSCTZcEWsKn+5olJ+9DuJDEmU21s
	IvYeBbZV74kzmP4Hp29TF7UsAV+lj4+mD0GL7blpEv2dt31ak03qXiRlidndVuXpz7DYw9
	AUHsb4nrDbSfkcI9nJ9wcgBpiEeZF7FJBwCBW3X4mT7Bb6mPua06idrsT+BwB99AC57l8W
	SNpQqC38QDh7lNFwFVIPXyPHtc7ykAdBlmJ5VBfqinRDVjBwvZR0rPw53QEFsg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] isdn: constify struct class usage
Date: Tue, 05 Mar 2024 17:04:46 -0300
Message-Id: <20240305-class_cleanup-isdn-v1-0-6f0edca75b61@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN5652UC/x3MQQqAIBBA0avErBOsLKyrRISMUw2EhUMRSHdPW
 r7F/wmEIpPAUCSIdLPwETKqsgDcXFhJsc+GWtdGN7pVuDuRGXdy4ToViw+qt5VGi66hzkAOz0g
 LP/90nN73A8yYIaNkAAAA
To: Karsten Keil <isdn@linux-pingi.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=769; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=93s7wGp3C6SdWhWiiV88Jt7u2fX7AdL7lbagzctieg4=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl53rkUTF3SBy1STs9k/BdRpuRXm1wVdtbfXlpS
 6WQnf3fw6OJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZed65AAKCRDJC4p8Y4ZY
 pi2OD/43gHaHlSW9E2PyFV9nxN7oqj8CK4WaSnOj13OqDGZkIDKcxedUB03p+lFfGS9q+YG2wW9
 pG0TcrXQW37ergZQUN7rlncjaotFIb7YYwMgTFVKoShT8u1fjk6BFx7wfGRs/s04YFjIHtXurzz
 sacuiFegY47Shmrk/kqM0EkA4wpbNQe7PiHqooObTOC8Tm/ReapN/6Fe7FfBgZQzNgiIz0CuZdP
 +b+e2yYCiGsoVSCMr8TOueq6lQQMvTiq17EyrVfHLT85xT2V2Y1H0FaOhzjZrc1lsyfHSfTqdD5
 YqpgvLwBOaePYJ0cyMmEg9REPx71Nim7AjlFkgqclyENtW0yZAKVLRvajIQ0rBGSoOJUNdYdbXU
 BwhyQLD8oYXsxpKvm8lDBBGhXNIbbDthfEUE995ISvU8uW+QM0tbCfdTGAw+ImwBgfKjZKXPaEf
 BtZVsycLNIzyDP567hIHgWYE8WKOBO13wPFTGbTPsbtPbvmcI/jOy4c/31UFa6AyNeF4hxX77CV
 FwUoc5n+8aQxGv7T7lpRDD1qDESL24eVS3bTFUi/frQgAHmvnKjg00MvLtRXb5HWaNURK2i0Y8J
 9zQ0/z116o7p+U46A8ZtS02MLkN9uhKr80ht4dKxB9FCHVVajvZiDyNHoyzcOyumKX+f1Gn+FtM
 MF4GGqfHgcJcv8Q==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This is a simple and straight forward cleanup series that aims to make the
class structures in isdn constant. This has been possible since 2023 [1].

[1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Ricardo B. Marliere (2):
      isdn: mISDN: make elements_class constant
      isdn: capi: make capi_class constant

 drivers/isdn/capi/capi.c          | 21 ++++++++++++---------
 drivers/isdn/mISDN/dsp_pipeline.c | 16 ++++++++++------
 2 files changed, 22 insertions(+), 15 deletions(-)
---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240305-class_cleanup-isdn-9810c8ca3e64

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


