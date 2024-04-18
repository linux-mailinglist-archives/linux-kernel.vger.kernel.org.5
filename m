Return-Path: <linux-kernel+bounces-150379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C247B8A9E38
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27601C21F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE8C16C852;
	Thu, 18 Apr 2024 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zmjzv2f/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839F16C694
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453704; cv=none; b=k2kocANq+2w1883THH45Tk1dULjUQLRgS7VBaRbMV+IHgF/P83KhG8R/CgH1OCOsBe0SVdSqy7MB5pvIqHg0CKA2EU/F1a0B+IOCroDWtxm8Mmo6jmaCrL+r9pGvxVxS87b1Ldkw4uyrJFYyNXbCzK9+X+yDlhjHc8bQa5AYoTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453704; c=relaxed/simple;
	bh=CQohQLqvPc/tHvgWJq7mh9PQ9WJ3XLzzwtQN4cmxGqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbwIz/5F0CoURfo6b96TSehxSnDEiGGEtbTeg6yiGfi12SrcX2OoE8wJKziJxVmEgP3AV4TGfhQ5ycVJqU5SWbwhb6RMBH6bwB00br4mxrg5kimYVKjYib6wNOPRqCM7+MrfGtv+JHkW9T0/FkH2BEAUz1vjWtzitymkHmQc+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zmjzv2f/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713453701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQohQLqvPc/tHvgWJq7mh9PQ9WJ3XLzzwtQN4cmxGqc=;
	b=Zmjzv2f/A/J1a1pFak6FlDxq1uuhe3+hV5q3QE0TjxI2RJD1xG8/+5Je2CTEAqsFanklzA
	sbYIgqQhNG23nGCnezcNdcygmW87NEUd6bq2BUMDCclU4An1Ye58HOt9Fzpean1ZoOcejY
	nW8NLleNSNhO+OxCIFg09oAvJEo39DQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-q68aKW9fPBmRvyFG7F9eJQ-1; Thu, 18 Apr 2024 11:21:34 -0400
X-MC-Unique: q68aKW9fPBmRvyFG7F9eJQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-434eb00e185so13498581cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713453694; x=1714058494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQohQLqvPc/tHvgWJq7mh9PQ9WJ3XLzzwtQN4cmxGqc=;
        b=ic+i04w2fbVfDpb2ggUX3VV0/crfxLfO07AmQSqmu/siCptdXRXUsyIDP1UYw0CVNw
         1uW9WQiI5x/DasgsfkquAfY2Dad/396Bcu7tXJj8Fqa75gODZpBLYAjrsJWgfj3zkm+o
         JCpjVw4Fz6FvZ56n5PiojYEYOsT819L1ihucgDtpe0SiFJ/Lg7mYrhrWri/X3J1F6nYe
         SD6JIwaQOWQwrNnfKovXhjsxctMlIkAR73xocsXr7xY+R+guCIAdoU0ZURuRivtcSfr2
         LbtVrHbaQMsz3b1Y2bBEk3mn3P6zJZkgEiP60CtcMlkpXPHaUwgZ3fJvOGgv4OmtfEAZ
         C0GQ==
X-Forwarded-Encrypted: i=1; AJvYcCULVEPwxZl+6s1Gq21qT6gcllSTuB7fju92bQzRhZxR4s8cx6/UJiY0hWzWkhYfPiNhEdC0PUL6fxFVG4+OCiJg3TWcQnG6nOfOXa/K
X-Gm-Message-State: AOJu0Yxe+FXpTwtzm0HETOAN5NvBARvOwyHkg5gnQeO1erJwYIBE9cFW
	rSIylmZnx1hyAuUsXWISqzPMzfuCccUa+RlE6gp2hml4pqh3oiVmAPBtY5PKumDiVM6PqF76vpq
	AohY0FFsiITloWW1vXI9G/D5gTAnzdLjCOspX/3TcqSg6eAwBIny3HdEkRWnhL2YwdmdH4ZUZhQ
	WpbZWEvuBAHEzoD5AXhzeRjNJxSqK7UdjRl3JtPYlgSEF9Kdk=
X-Received: by 2002:a05:622a:164e:b0:434:68ad:bc6d with SMTP id y14-20020a05622a164e00b0043468adbc6dmr3752449qtj.52.1713453694197;
        Thu, 18 Apr 2024 08:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYZwCA+06wOvVVCIasxw9xTrMHDeFH+2lLqLF9z2iIkb9Ub+iZ6WZb5a1fMomaWqQomkeAzQiYpEptyX8KM74=
X-Received: by 2002:a05:622a:164e:b0:434:68ad:bc6d with SMTP id
 y14-20020a05622a164e00b0043468adbc6dmr3752430qtj.52.1713453693884; Thu, 18
 Apr 2024 08:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418131754.58217-2-wander@redhat.com> <b96697ff-3177-4559-a410-104ca3a1110f@web.de>
In-Reply-To: <b96697ff-3177-4559-a410-104ca3a1110f@web.de>
From: Wander Lairson Costa <wander@redhat.com>
Date: Thu, 18 Apr 2024 12:21:22 -0300
Message-ID: <CAAq0SU=HJ8nysYWBj6_FGbRv5QyetdV0xJJKpn2oy6Hub7-6QQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: unregister the device on error
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 12:06=E2=80=AFPM Markus Elfring <Markus.Elfring@web=
de> wrote:
>
> > kunit_init_device() should unregister the device on bus register error.
>


> * Would another imperative wording be desirable also for this change desc=
ription?

It makes sense, I will change the comment description.

>
> * Will the tag =E2=80=9CFixes=E2=80=9D become relevant here?

I often forget this tag. I will add it.

>
> Regards,
> Markus
>


