Return-Path: <linux-kernel+bounces-16440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80343823E9B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E36F2876F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA4E20330;
	Thu,  4 Jan 2024 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="U3DQ9N2b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91A3208A9;
	Thu,  4 Jan 2024 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4T5Lnh4Ck1z9srL;
	Thu,  4 Jan 2024 10:26:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1704360408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWovRk+P/bdsn8nOpwKltuiPWTz3laevvMIThtgsQLg=;
	b=U3DQ9N2bxWLpnMjB8jxRrT2CWrDKzKvS2xM6N+qJgtYA4cBb+lOIMcdPPMIMc+dUFK26e/
	LeldvoC0v9WYfmGfwHw2vUN/1mEq2rvk13uNulTUtmBbT/5ml6b3RNBaccoN1SHYurrP7s
	8+PNXKI4mn2zVhsQmkwWkrR2dqSlJeS8XDjwpD2K0Wxv2hEHPjo8LZOPUdzT+G8aNgawBG
	yJCkdQ+SQNkFq5V69P7kNZ2upyRjDn0dbpeU3KEzL8bmOymmWEK1i5fIUzatt2lg924Clt
	4dOr2FUMA5lQPN9N8ePe26qSW7crROYoeBSbF/EtBZgomCi9vkW6S5HRlTp29Q==
Message-ID: <ff58a489-105c-4fdc-9af5-59efb9d05ec0@mailbox.org>
Date: Thu, 4 Jan 2024 10:26:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [1/3] drm: property: One function call less in
 drm_property_create() after error detection
Content-Language: en-CA
To: Markus Elfring <Markus.Elfring@web.de>, dri-devel@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5@web.de>
 <9b1e7330-f4f6-47f8-a568-eaea1624bb6f@web.de>
 <37647c33-7f9d-4763-8bf4-cfc5c9a811de@mailbox.org>
 <c5f1a7bf-b444-4934-a205-3c2b3a045ff7@web.de>
 <dd300771-851f-4cfb-b9a2-d87d2b4399aa@mailbox.org>
 <93cfabee-9692-491c-8d38-dec142e90252@web.de>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <93cfabee-9692-491c-8d38-dec142e90252@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 38e99d7ff20122c4020
X-MBO-RS-META: h6ub15cgqr57uqbao87qcbq61xrf345r

On 2024-01-03 19:08, Markus Elfring wrote:
> 
>> Without seeing the actual Coccinelle report,
> 
> There is no “official” report according to the discussed patch which is triggered
> by known advices for the application of labels in goto chains.

The commit log says:

 This issue was detected by using the Coccinelle software.

Either that's inaccurate then, or you should be able to provide the corresponding output from Coccinelle.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer


