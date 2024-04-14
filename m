Return-Path: <linux-kernel+bounces-144013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3698A40D0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460A4282304
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8263A1CFB5;
	Sun, 14 Apr 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPUr2G0Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34871BF27;
	Sun, 14 Apr 2024 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713078930; cv=none; b=sLWZYfn/KjYS0Yzexj+d2UY6PmfsVY48AdzVXDANxP81BbTBSxYks63RHcbJWzTT6GBqL50F8Hb8EQwZWvKAhygbB0vHyBlAUYXCczMn6Kp5WNAaDOtudPMbvLmqi52wfKAL5SMOfRu+BC52xn0OlSIU8hd3wcgGQaDWCn+byg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713078930; c=relaxed/simple;
	bh=5Yz1nVCv0nq+UtmqXiY80Lpfc5iAmOs/i9m5Q1XSGYM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t9nkKwT3FVVs2VRQWAy72ZN56+P/vyLB0w0wzqahhMXU/Z538lzpRzMGtNEKYwY9WTP2LjGtNhUtp+mTk8OkpD57HGRv4k9QglN28r6C7tW9YAXaEJYELVresc4C5W8rzh7+jua+eSIPbyXjnrYIupQxRYUBSIANpdW8fMIqw10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPUr2G0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602B3C072AA;
	Sun, 14 Apr 2024 07:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713078930;
	bh=5Yz1nVCv0nq+UtmqXiY80Lpfc5iAmOs/i9m5Q1XSGYM=;
	h=From:Subject:Date:To:Cc:From;
	b=SPUr2G0YBVOtUxl1p9uNe69PJA/FyfWWXsRTIRAF96U28G4FWmDpLMmlVcU/JAVWU
	 4lfPwzLIC2LiBk/1vdfvwbd/Tq7w3jriogUan0LtrAHy0c6oOhKx3xipa6cWUD81Sx
	 nzlr+SDWp0W0fXVRH+PRAEY3IftoeyGVLHCeaTDsKz7iM52lQaExiO3MW6vMeSJyIW
	 x7aYvR/9ag7IrIBXVQpsXnCRqhgwMpf5QRLPR1ONRcxPZZc+dzfekNlJekcTSiO2/h
	 hJncNfGofdhi9DYkxspJc7HlX9lK1eQGm+PzTHhAH6+sQQsd3WJ74EgFk5Q6p3T9ey
	 a6ytsCZmZdHIA==
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 0/5] mmc: Constify struct sdhci_ops
Date: Sun, 14 Apr 2024 09:15:13 +0200
Message-Id: <20240414-mmc-const-sdhci-ops-v1-0-178539d68093@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIGCG2YC/x3MMQqAMAxA0atIZgO1Vi1eRRwkRs1gK42IIN7d4
 viG/x9QTsIKffFA4ktUYsioygJom8LKKHM2WGOdcZXDfSekGPREnTcSjIci+aZrrfe1MQ5yeSR
 e5P6vw/i+H5afL9llAAAA
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Ben Dooks <ben-linux@fluff.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=krzk@kernel.org;
 h=from:subject:message-id; bh=5Yz1nVCv0nq+UtmqXiY80Lpfc5iAmOs/i9m5Q1XSGYM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmG4KGpwo3MQMpaueS5sff6HJfUHltgmd5b8Ngw
 AL3dyIcjx2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhuChgAKCRDBN2bmhouD
 1xNkD/9dqB/A4vqS2TB+V9/YUwMA5YX9804MJF4yZWtu16nDSvOtHAFp684aheSj4D3lllcdFIe
 NnDH9toG2nHWzYFcGcahC7/lYkVPedyU/ReQOD93HfD22VnOJdczdQiGxk/JW2ZbRzrqXyTBqwq
 YMIMF2YnTs7E9dIkBKPBHYvjBjQ8IS/WOlPp6FSKize8B4Z/rlCiAooOyXaMykRG6SyyzJKnrk4
 JmzZnGa0KQxbTfZQE5/gbmJuIwVGXy9OpfqMEMHV3PCvOugTmZMvQMj6kmo8GMjN6fahFJ/zwRh
 k7mZGikZowTQhqZ+nHpitnIlOECzzzR3d3VFswLQnbY2Exx0/yDsh0dAeOwaQVSuXr+tV1n6/EI
 cZRSvqOV5/coieHCAPqney0U6l7eBMCLQsXapADqU+RrfnYeCegIC/jmxeM5IZHlvQN4PkY0G/E
 E3kp50IY3+BHj2CEjV3IVHDk65N8dELEAmqi07o7+brHQAO933sW7BcsDZ37kH2k7vsvn1Lrbme
 b2oAS5Pm2XqDM/90YVCjXgIvpwRAPLUmF89mZvXmQ2w43eL85EfIPhmz4lVnAADuwtx2fC7i3nf
 hgO6x9zFvJMF6fvyh8a/PUT61j/q4sh9jolMyIA5WhHpRJHeqdmjJklVcWv//O8JqvB5pmvTnSD
 NIs1THbKlD/cfnQ==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

The local struct sdhci_ops can be made const for code safety.
No dependencies.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (5):
      mmc: sdhci-esdhc-mcf: Constify struct sdhci_ops
      mmc: sdhci-omap: Constify struct sdhci_ops
      mmc: sdhci-sprd: Constify struct sdhci_ops
      mmc: sdhci_am654: Constify struct sdhci_ops
      mmc: sdhci-s3c: Choose sdhci_ops based on variant

 drivers/mmc/host/sdhci-esdhc-mcf.c |  2 +-
 drivers/mmc/host/sdhci-omap.c      |  2 +-
 drivers/mmc/host/sdhci-s3c.c       | 31 +++++++++++++++++--------------
 drivers/mmc/host/sdhci-sprd.c      |  2 +-
 drivers/mmc/host/sdhci_am654.c     |  6 +++---
 5 files changed, 23 insertions(+), 20 deletions(-)
---
base-commit: f67245b3062cdc225b37003085bdb2916e1670b6
change-id: 20240414-mmc-const-sdhci-ops-c85762883004

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>


