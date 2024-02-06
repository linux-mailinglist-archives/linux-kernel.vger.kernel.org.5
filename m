Return-Path: <linux-kernel+bounces-54723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5902884B2E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 674B7B24EAA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EAF8613B;
	Tue,  6 Feb 2024 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVjKdDIs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC51EA7A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217015; cv=none; b=d/FKptAJH0AlR499vtISzuOv1Q5jaQloENMwGL8o/1EB8NWiSPOm2FeNtIHgfe8gHyYMn5e11mCoK1BauPDrVTihk3n9zAecCGSjBNab3Sn1UxRjNnxS5+FrSQNWGJePz+d0PMmfhf2NNjaD+kWW6d5nywvyfVqARjX50/+yG6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217015; c=relaxed/simple;
	bh=8vOg9PtERGFIzxGfr1uQ777xA4qgfnvqvPqJZtaB7dA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmdZhzsLjvKgMzOoLEV0H81XgMFK7pygtyGuaVPrWCPeRa7lsKHDYQlj+8uogkZXBxHy3fnGukExgii1MdjeSu3yiJX2U2XHkoyZtFVPSshbgcW5mNLvGJ88oBcQxRlJJ2RszcAlbKCCduXToxShNFabQcQZMioTwoY2C8l9E4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RVjKdDIs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707217012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NOcDAAfRrdOruM3vQufk8xXSJsuXJBYipbiUl5Fyob4=;
	b=RVjKdDIsSP0Q7OmBmNbtiO0JJ/ddL7gbF4tIuUVu58JvPlUy0SMNco+Y0PpWXFts19m9Jm
	uV8E3oMqcWf5HKL0kqmnHwx+JCcpFgOC7Bvjn7EdKw4HGsBsQak7ek6dCCs/CbYhBrNUYk
	SCVbIpIausJ+ok7Lk2phoncseslXF44=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-uPxI6AnQOc6Z9eg0kV6pog-1; Tue, 06 Feb 2024 05:56:51 -0500
X-MC-Unique: uPxI6AnQOc6Z9eg0kV6pog-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-68c4f2aca5dso95047336d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 02:56:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707217011; x=1707821811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOcDAAfRrdOruM3vQufk8xXSJsuXJBYipbiUl5Fyob4=;
        b=BEx+yXNE6grtFCWM9BFgth7dhXQep7Cp8GKXQufNyKCNSIjBb1l1nhqImed1s+vFEq
         iDyzz1FlNu756EP4vpC5I25iViPHcNuoZQzOd5D4ebLNJLXKRuobCrldkE3O9LRP0h91
         W9OS7Y4cnpxEQIDFXDnFAVlF5uMlzSoUdJ3kA4kFEmKiHvhKOJ1APy1aX+ed5MuDkU+K
         jaieI072aZokNlz8D771RUk4jobdWzkTZYLoVyZgjt3rKi6JIDPKvHSSlu0MyBHKNmbP
         Nea9WCgphuO4DPUfNuqgjEltfODXrIRSYOWTyIXv+GsoXSovlHNw0HauFQAfnOsUsKo5
         jcVg==
X-Gm-Message-State: AOJu0YzW7/JVz6jIHZpUvLdzn998fxDxihEc7OPWPE4FAB1TYJhgc66z
	vqHnRDLso99zMOzx1Imyi0RZX9CBMlRAD0I0E5Y/SWHq227ebqE9x3yjGilBA2hEVBbWbVADUpe
	vZFDlD+Q6wLzF4j+s55Uh3MjH3rFdoDsfg7tdLbM/nYBlHOqrd3xg8s9mIlHx
X-Received: by 2002:a05:6214:21e9:b0:680:f8d2:c828 with SMTP id p9-20020a05621421e900b00680f8d2c828mr2323851qvj.16.1707217010851;
        Tue, 06 Feb 2024 02:56:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhff2DlHZd/ZEK5FY5fiFC/T9Pyc4sJSO0MZ/TglPCHuCL3o0cMWVg9QtToY7v6Z+KW8fOWg==
X-Received: by 2002:a05:6214:21e9:b0:680:f8d2:c828 with SMTP id p9-20020a05621421e900b00680f8d2c828mr2323839qvj.16.1707217010625;
        Tue, 06 Feb 2024 02:56:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUy6sn6pHYdmwklCBeIPLcmA1sdU6HtNEqv2vI89wRaRuOTRoeDVvkMZSTi8k4LvKuQ+uw3wya3VWjclc935+MWSLQ1FLMXeUPsNKCqJwqo0N6g9CaWIXEbpHIvFW4hY7hdrx/83/UaLEwREYUxlSfIj5OurBwqw55BcvAuQ+neLuoy4C+Z+fIT9uVzHZvhMc9Sz4UEcu6C+LqYKemieSEGBzAP8IaKN126K1tr1tdC4NdMTGdm8oh6aM6Phr+EB36wRQfo/rv0tJjtyfcAZEnIX73Z08xwdYPfFImmhKT+pjVQWpQmPMlEnwVxqnnVrD4ZhbO4AMKT0PFYi1Oki6vJ+bbj
Received: from klayman.redhat.com (net-2-34-24-75.cust.vodafonedsl.it. [2.34.24.75])
        by smtp.gmail.com with ESMTPSA id hf15-20020a0562140e8f00b0068c95b634d3sm909547qvb.11.2024.02.06.02.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 02:56:50 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [RFC PATCH 0/1] fpga: bridge improve protection against low-level control module unloading
Date: Tue,  6 Feb 2024 11:56:43 +0100
Message-ID: <20240206105644.41185-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC proposes a solution to keep protecting the fpga bridge against
the unloading of the low-level control modules while addressing the
limitations of the current implementation. Currently, the code assumes
that the low-level module registers a driver for the parent device that
is later used to take the module's refcount. This proposal removes this
limitation by adding a module owner field to the fpga_bridge struct that
can be set while registering the bridge.

The RFC patch is based on top of ("fpga: remove redundant checks for
bridge ops").

https://lore.kernel.org/linux-fpga/20240201155713.82898-1-marpagan@redhat.com/

Marco Pagani (1):
  fpga: bridge: improve protection against low-level control module
    unloading

 Documentation/driver-api/fpga/fpga-bridge.rst |  7 ++-
 drivers/fpga/fpga-bridge.c                    | 61 +++++++++++--------
 include/linux/fpga/fpga-bridge.h              | 10 ++-
 3 files changed, 47 insertions(+), 31 deletions(-)

-- 
2.43.0


