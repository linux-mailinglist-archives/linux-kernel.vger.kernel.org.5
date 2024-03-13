Return-Path: <linux-kernel+bounces-101426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EF087A6F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1372D287B19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3EF3EA74;
	Wed, 13 Mar 2024 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEI6DrJx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC03D3B1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328471; cv=none; b=Aib1CFHzcaGbxeJxEGJFo9fsvhfk3gFbP2XI8vfAlIZ+bohi0gqAULlmCs8dGSyEnWxk1PgnBTh1NYmTnbMgq2ivFJMWdVSBTKWy5HjMPcQXNg3NG8sU195A1ornhkxA3yqAUeVi8I5mtN4tZpSNgOScXZ5wlLf4NnwaQvWVs5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328471; c=relaxed/simple;
	bh=HbsPiSZiLZuvC7Bw0pUzyKyQkcDR5oghfKlA8aZSUH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FN9f4FiQEEQmorFyNTV//5tafuE5atU5fxfq2nURNYSNbtPYEFZFcXgSq8ZqGPcTW9UbXBbEz2Ty/UHKO7plRzSW+4V69XZmA2Ye2XnwE7QWSUG0JlsFHjPXRHm/8yRx04d5AJ9WZ4Z5VrBfKV+Mq0H7xzFgJYSIbSqkKA+CTkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEI6DrJx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710328468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0GqW7xBDUz604Sa3jXvzrWYTHr9T0/hZBEYMVEZaQI=;
	b=EEI6DrJxr8Tw6bHYc/7ZS2h85J4565cpAm9FDwQ8sgm6ZQOK5P3oZNSisccIfaZU+/SfNY
	wIfR7CmtPMuc+eftixkGJA5OEkP+BaEhLOWXYOOCEgOaUOA0+lvQs4HWt7z+udxL0ApNRa
	IuOFpqIIbmqeAIjbR7EL7chBe23Ew6M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-yWAnIh15PhKRZxmXRgdfGw-1; Wed, 13 Mar 2024 07:14:27 -0400
X-MC-Unique: yWAnIh15PhKRZxmXRgdfGw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33e9203e775so2018923f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710328466; x=1710933266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0GqW7xBDUz604Sa3jXvzrWYTHr9T0/hZBEYMVEZaQI=;
        b=f+851EToXYCBb8pbgrqnJqfCaB6BgkSu3pkyBEDGfF0+AnG4VBM3PEtzVJ7D6UmcHL
         Of5mMSqyVeFJKGFzIyafQZVELsOQkzXqbKWhuNvDXuIGmHODviyT7jHxlqFDvWVgKnxA
         yaRWDMGgIYsxS32kmwK/g4ENiLA/3W5gfu26V5rmKdmrK8gZP1TP9ACsynlRtGDzNXgW
         ZcIkz6doiHqPpKiBtmgEA+4XYiZf31UaxuQ5SAlfBQv1qd9d5McBNrXfqT1xzZL+CgXl
         1ZRWWbvLe8UKDuISb52BvsBHeEIdpTcUvQ43CoFDUYQ8mAZvT4x8IVuh7GTQByuhE90e
         njNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0e2DR1hw4fCrXNCEjZbyrIEamv6qXHO45S9yojFgXr71BCLdXI70OGQbZsSit2ezeeiXEKP+8vnfqyNdziTOzNaYu7i/XwOFGTbjf
X-Gm-Message-State: AOJu0YzP3KrjfG1+wpSg2dlQnx9+zZ15UeliX/cjJecqY5C626Zvv+cj
	4b5tbiz22W9rRimZrd7y0Q5kpIJYwkPCu9hZO/+B14oxLdaOn7kcXhsWppadc0HX0ZU3PViQDcU
	IkMrX6mB9ESrq+m3rLhtLEOiAJ2KyUtr3l3OmqBAD/2bITktDBGFjpg7+Sgn+S3a3dETpB9k1QZ
	O39qRwIcHMRtjNKNCnfehqco5I2vOlPNV8HlhQ
X-Received: by 2002:a05:6000:1845:b0:33e:34b7:895f with SMTP id c5-20020a056000184500b0033e34b7895fmr2037354wri.24.1710328466373;
        Wed, 13 Mar 2024 04:14:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQCIGIRkhQHVb3DstYf3kXLe8waQUx3BrqHnYehfHc9OhoVVDC6vfotsn8lZEYQgMrPHv39WvnmJScfSrgowk=
X-Received: by 2002:a05:6000:1845:b0:33e:34b7:895f with SMTP id
 c5-20020a056000184500b0033e34b7895fmr2037342wri.24.1710328466114; Wed, 13 Mar
 2024 04:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313091259.1413854-1-ppandit@redhat.com> <0a1aa580-50b2-4657-8308-94bffb194aea@moroto.mountain>
In-Reply-To: <0a1aa580-50b2-4657-8308-94bffb194aea@moroto.mountain>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 13 Mar 2024 16:44:09 +0530
Message-ID: <CAE8KmOzcD+__7xdC7tegbHO9HEP48s7=reA4j-tvqVDwzHr+8Q@mail.gmail.com>
Subject: Re: [PATCH v2] staging: bcm2835-audio: add terminating new line to Kconifg
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, 
	rjui@broadcom.com, sbranden@broadcom.com, linux-staging@lists.linux.dev, 
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, 13 Mar 2024 at 15:47, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> Why does this make a difference?  Is it just because it's annoying to
> cat a file that doesn't have a newline at the end?

* It's not just #PetPeeve. I'm trying to fix parsing errors reported
by the config-kernel tool[1], so that users can view all CONFIG
attributes without errors.

> I checked, and it's not a checkpatch warning.  Perhaps it should be though.
> KTODO: make checkpatch.pl warn about files that don't end in a newline

* I'll take a look at checkpatch.pl.

> subject but he's on vacation...  s/Kconifg/Kconfig/
> Just fix the subject and add a line to the commit message and I'll ack the patch.

* Okay, will send a revised patch.

Thank you.
---
  - Prasad
[1] https://github.com/pjps/config-kernel


