Return-Path: <linux-kernel+bounces-92413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557FA871FD9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F581C22364
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0E585C62;
	Tue,  5 Mar 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="YNVtc2Ut"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CD355E77
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644569; cv=none; b=DAcf7RLhXTD1CR8bPjBVrd7hA/l15mShmlK9UV9zi53m+rIUkUnWPIPQ64HcmxONnqrA5PJsTHVsjngU9i26vG8ymr3QfmEr+hUUY4Qer7v3QecOZ27KiJpUZQppjlx45L1hfqtndM9I9rCKSq64tfFFfV0BhlvJsHYJ+HLrv8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644569; c=relaxed/simple;
	bh=8XNq4Q5n6PPg3j924WkY2krkAvgW/p/prb34aDD/L0g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oSFe1h3WnhzQ0zKxeALx/RvNNBXmnSdLn1rKnLeZS245dYkNWupSQ6BZEiDn3RtrxQPG15s24E6DmOSn3iuQiTUsNcFurqnmOtN62s+xzjOb61NlYmvQCS/omjgsxe8ygZImJS7X5naEZ4YCGmreZaxYs9JEKGGuIfLgReO3GqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=YNVtc2Ut; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e63e9abf6aso433219b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 05:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709644567; x=1710249367;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IlVgX44R65PkQMZQ9beF+VlRKBmaGhNPco+GYuCp2vI=;
        b=ARWn4Oeete/J8IxFk75ajtw0nd2STcxqlgzZ6ZSdmtTZ0EOdFYv+xSJIpmCKKQzNxd
         j9LAovYV9JvUc2SVTROSxAbwyYTjFD4zHk6hQXkh6LrV1mPw9pGYfFRSw8v46kyY+CQY
         DdIORSDQ5rF/j+W5+thZM8ixjpxUV0F6ERmJYCzv/bxpfqtZOGjyw4jWYVnTmlQTydXE
         8mqrsRu//HBUR2Ms/P5ACjOlq0KM8QWcgNtbMAHltILramgNIzIJil3G26dAH2wNGIjV
         CISfjKUjZSs9KcShuJhphUyObJI5iNwDmk+LuaswmXUSdsph8AqIvh+21YeGStMMPGJL
         VvEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnaHfLAfPoRFr48AB1kdbZh4HJ+OkXgm8zCMLKvaHuSmySzae833cUrh3jJ7PvngKcgwOTa9x0aXEEyybOYLu2JVPFj//aiGg3Q6+p
X-Gm-Message-State: AOJu0YxbJKMd5izhyzznv1hSPJ+499r79wYxdjL3kOjoiXOV6xGyL2WA
	KYgBfwNuhZmCUfAPJ5a1CFHIYk1M2/pB5UAKf0+XZ3Nuh+ruNLqO
X-Google-Smtp-Source: AGHT+IEYoKkZLHyXa2G+6BzBxGBU+sy/JkPIG76Xwt7x3+dLYKcpYdRDHPgMRFY4V7tWdPsVDWRSkA==
X-Received: by 2002:a05:6a00:238f:b0:6e6:27d5:4182 with SMTP id f15-20020a056a00238f00b006e627d54182mr5235576pfc.9.1709644567518;
        Tue, 05 Mar 2024 05:16:07 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id x7-20020a626307000000b006e624f5c866sm3504674pfb.145.2024.03.05.05.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:16:07 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709644565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IlVgX44R65PkQMZQ9beF+VlRKBmaGhNPco+GYuCp2vI=;
	b=YNVtc2UtO7pVpo3uW0AxjiN0Alhbu3UO0QMI/Gv3xagVMJdPVSPO19PY2MQfTbvUdM4fEO
	+glmj5naNaI7XrvtTX6SAeZVjCQyyPXekYm59ujGt8DfEaurumImSa6j8gbogeSxwwsnWA
	UCOKKW49gv6fIbeqZvdxwI9JtYQ35Kp7xrCnUFjBwOuSonZaGlWtHjhQmvG2bCCRu4XYA2
	cb6b1Hgcth29N2MQ9PCY+IcieSqJwMpnzSxCD/1vUXfSSoPDPgLYghCnTAS0nbj0gcy+1o
	6txeqFTWgl9+fLiEv6Y0lBJBYaOq75f7zW4U+HHyphLayw/zKE6WF2oht2+UGg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/3] nvme: constify struct class usage
Date: Tue, 05 Mar 2024 10:15:55 -0300
Message-Id: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAsb52UC/x3MQQqAIBBA0avErBPUCqKrRIRNYw2UhUMRhHdPW
 r7F/y8IRSaBrngh0s3CR8gwZQG4urCQ4jkbrLa1rnSjcHMiI27kwnWqcO+k0BhP84TV1FrI4Rn
 J8/NP+yGlDzF/c0tkAAAA
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=8XNq4Q5n6PPg3j924WkY2krkAvgW/p/prb34aDD/L0g=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5xsR+QBdfjwxESwx+GwAh/Mhmi9UlsDoNCQyv
 iscKwq6RfSJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecbEQAKCRDJC4p8Y4ZY
 phgfD/0TpHpD3XBqsjJO0k5Vtvt/kA3emstwrh+ablwvZDNxMk25pHr+hqfZl3YJhbE9B5Yu1l1
 KjxEScP/7EAGaPiDDcemeD0rLSUnnVKRPeBd0bRngWOwCCL6fdW6jgM13dnsNUhkY/ZU34SjVdH
 yKofPj1Qzlp9RES9KFqGqeyFIGL90V9buRT9iLdEYp5904LwM95CwwAEg+91wIV522q19pTpyW/
 uSBA5zEikf9ZaJ/mI9WXjdUUPc1gRRwtiEMRmTNd63rfTCHqbymzcEiPAJEcaQG6QB78uPssEGN
 9VcaigIBCa9pQXtc1Tgn9Wh3UiRBDdHWXGj/gf1eTy5h5EVtXZw0+p5MX6HjgQgWyNUncVbdDJ/
 kMjv5c9YgrSA845rxLiXBdUCDFYhg4NFk12q0ohu1JUQaHa/hMXywLL5SBODnkFJV0qTMUIKQSM
 BKEAbQ1vPgE051XGtEZBRyD8INPoNPwhSBfjZ0xkPSHgjvBxB5ubERtHzN/s7Xw9O3RZCiKRdFH
 Kf5bqrbwM8W35G1rL4+tfJLx0tcrhq/Sz7VZ3fk7waXICikdvSOwtwqZ0YvbtsbPSTS2IMOZiN2
 pgKGkNNpW3Xn/fE03Hoy/zPnWTdMb2VbuQhdsEpInVQ89rP5LHE7a7fQKPNUx3iAcnP04XuqSQj
 5i6aCqUw5JtGe2w==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This is a simple and straight forward cleanup series that aims to make the
class structures in nvme constant. This has been possible since 2023 [1].

[1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Ricardo B. Marliere (3):
      nvme: core: constify struct class usage
      nvme: fabrics: make nvmf_class constant
      nvme: fcloop: make fcloop_class constant

 drivers/nvme/host/core.c     | 53 +++++++++++++++++++++++---------------------
 drivers/nvme/host/fabrics.c  | 20 +++++++++--------
 drivers/nvme/target/fcloop.c | 17 +++++++-------
 3 files changed, 48 insertions(+), 42 deletions(-)
---
base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66
change-id: 20240305-class_cleanup-nvme-c11fedbc3b82

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


