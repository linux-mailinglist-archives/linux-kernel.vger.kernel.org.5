Return-Path: <linux-kernel+bounces-164611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 223EB8B800C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D118128124D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A1719066F;
	Tue, 30 Apr 2024 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIPhQ9br"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2025172BD7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502874; cv=none; b=fVyr+4I4ZZLLg9o0/Sotmf+kYSCs1YjudsXUCDl77/owTnPS+e6wyrAYwyfG81itv5oKWf+C7mOTCJWYAahlph9RX9pYb4S/AaAc+owpmEM/c9DPxp0mh1sv/VYX4MYlyMj9k3LfNlwSWCqB3AuQ8uuhCsx4h5V4jb5Ok4+/k0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502874; c=relaxed/simple;
	bh=kGD5LDeSbcCCWAZ6A/xTsiTIRSiUSuZbqr6vAjxd3Cw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n+cWIQUOYsUUyZwNu0St9MF9+gDlGt4s2P3X3psFadRdSeq4Y17aagdHIdgPIMArindE83Z9N5FP4nFwXrs6TQQRiJANWvigzC2J8PXxCyy3ne3Mmvp/0XhZ2wDoLapaUtGjKGDVxXxO0jlnG4y7bZDwAmYSQZwModvFiw/2Bqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OIPhQ9br; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572229f196cso6372711a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714502871; x=1715107671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maRahzj8h5WVnvC+mJW92etfXWS9KKobW2gRJpAJKic=;
        b=OIPhQ9brVvcrUCrjPLZwRiUAcc//4HY18rBPHNyAB/zeZvdewEWQpWlU3H+PkLi8Bh
         1iOc+su9uPMdSyhi5IxzKaBD6m8oIRUFZ1zopP2AwOpCnGGkhxUdEVZr7TJcuH2kASUW
         I6m2KwyN/9WNjrqnDSfXP5YcPxdqi6CIw9UkEUXAi3LROu9FoSP97rL4V1u4RvaE6wkw
         1/KlfMHmR69+Xvafn/jIaBX6cz0ZaVWV3cTIHGPDCEnyenZSdhoR9YRb2bgi8q2jEbNB
         B4J2v2iEPdsCmEHtSlD5i2BjuJWVaSNL4kOuZJwhAO6MJ93zRyJ+zmealJEEI4QVHJeK
         UpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714502871; x=1715107671;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maRahzj8h5WVnvC+mJW92etfXWS9KKobW2gRJpAJKic=;
        b=b8uqjX4J+lF0bNgdCTFroipVd16Hjcw5wbA7FedWx+zy4NQVdWdPZROXtNGPqY/e+y
         gDvqE/PKBaIfHohReGkjBPIgSMOKuJcQ/nIW5iNBQyCPSZoItrtBdc7M5S5+b8KPoCMg
         YIoAsQUFSU6CrZsx/P0+lB+3VriD8nkwfrtjeN2KsGX3IC3XqgvXAepfvLMpov5U87pR
         yUNlCvPiB+OfVHI5WCdaLB4mxSpmpBAN6qoUMsomJHWuNVgfQY0u8WSRMfNmTX3CP5tm
         scq7aZThmkXC+hRHEUWELDOv34i6241ItUfECAWv4X0FKUGsE4v3YrKQnYfCPZjCvZjt
         2I+g==
X-Forwarded-Encrypted: i=1; AJvYcCWY8ioDZWX1KSkCkebVrW36vny1p5kor6ktIh2KhoXnYUzoythtWyJ4IJchtK1HLKd+UcN0Y1xEXJxnAgy4ZqmjpWuGd+tJDX9AyVyN
X-Gm-Message-State: AOJu0YyZB/b/kZuI8VJ5LUcPbgwup1WPmnrAaxIVrugLTgxk9syoY5Nx
	/sv5onaDmOXUi9y4N86RvRWKI7sgJmcBUxW07sdh1v4qzovLVT0PioPG1pyqZrc=
X-Google-Smtp-Source: AGHT+IGJbfmzfuk/vn40VU5LkNZp8KDxHuOXhqtzXfBuMgXu9HJtS1cNimFP4kK9KcbpUyPCXPodzw==
X-Received: by 2002:a50:99d1:0:b0:572:9f40:514d with SMTP id n17-20020a5099d1000000b005729f40514dmr458430edb.29.1714502871081;
        Tue, 30 Apr 2024 11:47:51 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7dc0a000000b0056fe755f1e6sm14333569edu.91.2024.04.30.11.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 11:47:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 alim.akhtar@samsung.com, Peter Griffin <peter.griffin@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tudor.ambarus@linaro.org, andre.draszik@linaro.org, saravanak@google.com, 
 willmcvicker@google.com, kernel-team@android.com
In-Reply-To: <20240430141445.2688499-1-peter.griffin@linaro.org>
References: <20240430141445.2688499-1-peter.griffin@linaro.org>
Subject: Re: [PATCH v5 0/3] Enable UFS on gs101 / Pixel 6 (Oriole)
Message-Id: <171450286905.358014.14131394137410804196.b4-ty@linaro.org>
Date: Tue, 30 Apr 2024 20:47:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 30 Apr 2024 15:14:42 +0100, Peter Griffin wrote:
> This series contains the dts, dtsi that enables UFS on Pixel 6 (Oriole).
> From v3 onwards it has been split into separate series as you requested.
> v5 has been rebased on next-20240430, to avoid the conflicts with Andre's
> USB enablement work that was recently queued.
> 
> Along with the various driver code UFS is now functional, the SKhynix
> HN8T05BZGKX015 can be enumerated, partitions mounted etc.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: exynos: gs101: Add the hsi2 sysreg node
      https://git.kernel.org/krzk/linux/c/b5f5fe4b317c0fbda725a44d9c92d97930ad68e9
[2/3] arm64: dts: exynos: gs101: Add ufs and ufs-phy dt nodes
      https://git.kernel.org/krzk/linux/c/4c65d7054b4ce8ceb30ba2b8aed90ceff6158d73
[3/3] arm64: dts: exynos: gs101: enable ufs, phy on oriole & define ufs regulator
      https://git.kernel.org/krzk/linux/c/aaafb21e8190cd2bc8cadf3e0f017bc5c11bb109

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


