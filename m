Return-Path: <linux-kernel+bounces-56139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51E084C689
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 395DEB26383
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED52208D3;
	Wed,  7 Feb 2024 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="osqGZLas"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03B208CE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295501; cv=none; b=k+6XcAz8lZa9WYAuJ+cyzQ/iiDIcD2x+mpDXJnOzruhOIFzE9fGryiyHcQUGbueBFzyIarG0hjg20VI9XGUV5RBO/79FcBE5oc5MBHY1GsY7H9qEGGE1DQwyt5mHkASSmc6oCgH8kzSZ/zFnqHRbRwU/u1hqORRldPEDx+ZjwvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295501; c=relaxed/simple;
	bh=YTPZcSINU7lQwWahDe2E8XZsVbApJNCaAHRu8Dse6tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdn4+xxoA9clFVM4rultjp+ddAe9LXUshv8XKkI7v2QQYDkwLeiDZKvltNrhFTIW5YNtR4N2e9+PIx24NtX37OQKzae/Mmm8nv90Dr6bUyUVbQlA3XDZJpCLVA24po/ZGB+n0aDSAZRHxLccr+aECrzXkZr9NjrYI0gGMLnN8BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=osqGZLas; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55369c59708so65479a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 00:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707295498; x=1707900298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIQKW6QdXz2vaR/7LGjw7ltrzBRpHViscM3vHYU14HI=;
        b=osqGZLaszV5i952siEuXVuXpU4pa2ukrtQTJ5NboL+LFW/HD3NFChW/6s8ZIMQ/ATl
         PMgZio+MSsL/YkZaW2PJnQ4OGdkJQ1WTWpkZ2mn4pw3HVe8ifkeI4kXMq7Qng1ewkXsZ
         7/C8H1i+kYVBbEZg4GoVvRyWd794YkqY48V3z/XmwqDlGJALSafSMUZVNQO77/ztdKnd
         Zrb83d6qqNgACfZH4IDyltWGcagPZ8gyef2R2myC6E8rwt5tjqU6AnSXaGGL2bFjTxm/
         CgvNxodJgGTZj5iOtpSE9wgdpbZGx25coHhYJYaulYAsBBZp3PqkQu09yo1lXjhz5i/2
         311Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707295498; x=1707900298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIQKW6QdXz2vaR/7LGjw7ltrzBRpHViscM3vHYU14HI=;
        b=imZmAERN8rwMXk/B/N9MtIGHXD1/cOit4xhFIwqkK1blpvyyAMp73yBNQyADWntqri
         /5xBdv62+BNBXml4bJfmr9aASr58gDTsfYnibg6xRPJGyAoV0QVEOPpvu9DnqO5+qD/m
         SHQHGr0Rca1e1JMgn21ScgYq2WdTpB0bDIxoSztV4nLcI3wUI+yR0NdCywe3Sua3cChu
         mt0wiveJctP1GCHl/wFulDceLov2pyNwWbNsTRQbQUZeE3Dow6ftS2t6NEw5vEaRb0H4
         7NxPU4oSYAHyPKdos5ie3NPWDkGWGaiH+XBq2qehZOitA8VScabn+9qUFfV5uT5pxlNw
         BNMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu+UmkXe3ESDAiyeXzXiU+TZm30kMWmVaFm3DeTSjHBZdM0VvFbi+aMUBW9RidNRPUPL/s0btz8ONUtfcv5YHz+Ls6Ghu5sI0kFCDg
X-Gm-Message-State: AOJu0Yy/qp3sC77n2f1O+CV5ylsc8/+6dkcFhoI8Lw3JvXVtkRdSelCL
	GYmmOY16J5sWlrqhX4lsXA3r1lyBXx64Zml8AzRg8wz57L+oCAmlpPEZ6fY8Blg=
X-Google-Smtp-Source: AGHT+IFWzKnhbhGinj2qOQCqkp3swKH8rjdtW5bBb/QgmZglwFyBoNmw4mMFkpf3Vxg3rpxHHgSqkQ==
X-Received: by 2002:a17:906:468a:b0:a38:24ba:99d9 with SMTP id a10-20020a170906468a00b00a3824ba99d9mr2634457ejr.6.1707295498258;
        Wed, 07 Feb 2024 00:44:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVGH4z0ynpHbcdPWjccBmirwpr3RXHiKwQz/4yWilxX6y5d8K7JDWFBuswl8k9B+OKS9Mm7LXDGgBtK6rMDrNslFrHbP62gg13S7+N1X3kONw5MQ8vfM6kACCRtbo/IgWf/7Y33j669EFCiyCXAb94QwiatHul1ddzcqMJjAGefasOy8kOQV9rHnwdeZIzlEmu7m2xlnQehh1ZY4Ob3SWmoqKC7BnghVi0bpOLYsTaUw6Hw3zDeWlAUPm+XtqX5m393cNJcG0rdo6z3PHyxCH7OlrKeUOARFLfvYOc37lFI7OcLXlrhRlW/KhKZ8U6ye8iLMHBG2X0XrOEdoAqig/oaLdO6dVkYYGSaIAPbOkS62rNxP2V9RfdVQ5Wl9SpZVjc0PZY3Z/b003h539igAtOurKUFp4IueZ3vdsxx+j4kHrW4hmASuX+1vUBuayzxDLYeLPCsrho=
Received: from limbo.local ([2a00:1bb8:11e:cb8d:24dc:94bb:6d8:7d12])
        by smtp.gmail.com with ESMTPSA id u25-20020a1709060b1900b00a370a76d3a0sm493921ejg.123.2024.02.07.00.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 00:44:57 -0800 (PST)
From: Daniel Drake <drake@endlessos.org>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: hpa@zytor.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	david.e.box@linux.intel.com,
	mario.limonciello@amd.com,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux@endlessos.org
Subject: [PATCH v2 2/2] Revert "ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default"
Date: Wed,  7 Feb 2024 09:44:52 +0100
Message-ID: <20240207084452.9597-2-drake@endlessos.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207084452.9597-1-drake@endlessos.org>
References: <20240207084452.9597-1-drake@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit d52848620de00cde4a3a5df908e231b8c8868250, which
was originally put in place to work around a s2idle failure on this
platform where the NVMe device was inaccessible upon resume.

After extended testing, we found that the firmware's implementation of
S3 is buggy and intermittently fails to wake up the system. We need
to revert to s2idle mode.

The NVMe issue has now been solved more precisely in the commit titled
"PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge"

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215742
Signed-off-by: Daniel Drake <drake@endlessos.org>
---
 drivers/acpi/sleep.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 808484d112097..728acfeb774d8 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -385,18 +385,6 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
 		},
 	},
-	/*
-	 * ASUS B1400CEAE hangs on resume from suspend (see
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=215742).
-	 */
-	{
-	.callback = init_default_s3,
-	.ident = "ASUS B1400CEAE",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK B1400CEAE"),
-		},
-	},
 	{},
 };
 
-- 
2.43.0


