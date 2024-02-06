Return-Path: <linux-kernel+bounces-54537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BB584B074
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F251C20FE3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3702F12D76D;
	Tue,  6 Feb 2024 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epbaG7tz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0760312C55E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209674; cv=none; b=bgHnUNMWCSL4r0xuVmj9jsraQzIEsqJPc7aukPPMgU4b7cXeT2QYqsQb+0Ja3tUG9NwSo7VW4jZfutq0bNyJ+9K/J0jjtgcFn+Nma9q/kpQuBbPGLbG9p7PrS72v2J4NFxfP+AfsJoT11HUps/PYxNJybIw9Tw0zwauzNbWHwSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209674; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DMGCbMeOVrpauzykUoZ4Ut3OQEadUNHfZipvSXxeDlVTUDcii04fPIMFnIfnMsYVXA468KKr80JimO+U22f7mf4Krt8XykB9Y3klmTbqszP8OuH2rdDFr3b6e/WJE49tmIXCJ/IOUG3wo94CNVHwbFwtbyo5M61BHfGAEpxSheI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=epbaG7tz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707209672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=epbaG7tzP1Y86tJRGGDByEufoYUDjI2MPhXPEExClam+z1RlM9jwADMLYOUpO3SaDfjpg4
	VzTxSs4G57v/qEK6aUCKoI1YHQNUp1GBSdPJkTRhL24c7nV2mb5otQvBOEu+/1GbjnDqmE
	Gb/fxhqpVGJLW5VOzXeUdQGYtLTJcyk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-b5yTF-sQNnSYpfbUNxo2oQ-1; Tue, 06 Feb 2024 03:54:29 -0500
X-MC-Unique: b5yTF-sQNnSYpfbUNxo2oQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFF2584AC60;
	Tue,  6 Feb 2024 08:54:28 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5572D492BF0;
	Tue,  6 Feb 2024 08:54:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: pbonzini@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	kirill.shutemov@linux.intel.com,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	patches@lists.linux.dev
Subject: Re: [PATCH] x86/coco: Define cc_vendor without CONFIG_ARCH_HAS_CC_PLATFORM
Date: Tue,  6 Feb 2024 03:54:26 -0500
Message-Id: <20240206085426.3262128-1-pbonzini@redhat.com>
In-Reply-To: <20240202-provide-cc._5Fvendor-without-arch._5Fhas._5Fcc._5Fplatform-v1-1-09ad5f2a3099@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Queued, thanks.

Paolo



