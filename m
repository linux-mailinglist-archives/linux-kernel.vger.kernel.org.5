Return-Path: <linux-kernel+bounces-27759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A529682F572
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF281B22578
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF531D532;
	Tue, 16 Jan 2024 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2WcUKQ6a"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB7C1D526
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433734; cv=none; b=CBrEdhf5kyxZE6K9G8vQ/Gn3K0GTDqab965cqRZ8X9Uq2FMFnc3+ZHZH5iaS8Tqjj427Z9ecIjtX2RuScTYPzuF/Bim4OS5Dr1ZE2wP3TBq4JNkPS0t++4dNouG0jJckiModMZjaEubXEwJt6i8c0v08bXI7mxwdTYuaAfVpvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433734; c=relaxed/simple;
	bh=evrxQ+WlZe/uz/I2gq8N6P2wlxnDtK9mA/7hhyJoZAM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=MXcSDfHSp/tzRwt/LrUpPpHNxKiTK5OsfvNYwonvdpiDx1I7SgKv7gp5ppUighiteeDyXo3XX6kF/pqA1QWTvNiyo3gAxiHf+4XjEbqCxzytuAD8XOP4lMp6AX1beb3VGXIIAS6C5cd0jpYnUUoduiZYrnduV3g0PPJ2cl/LrwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2WcUKQ6a; arc=none smtp.client-ip=209.85.160.176
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-429bdb17616so42401cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705433732; x=1706038532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxJ9VvvDNT0D5B8Ol+QCsSG9ibygcO2/FPAnh3xxvBs=;
        b=2WcUKQ6a3Hemm/Mmhvyi8n6LStvrHnCK9qrvonAtiCR2iiSpZcXy7O/ctAMi+XYyK/
         wIoIirACPRAroiwVz3FIcCZaPJibWeD52nYxO8UsxCxl9vj3a0OWkwF9Isz3oPhtiaFN
         bAaZCRTMWjEf9cUFlcLcpvQWNrogRwwmlgUJIJdR6NP25apGeeON2cM84jd3qFw7It14
         94Sihm0CQ48iDSqFcOhLRT8rbazygyrioG5txeUJ3HIxOQf3gSUKhK9R60G7T621/y6R
         va7g+Od0vuUCN8KE0Skw5mpUsocNRy87rLvUvaYatHhbhaFmGpXYQo5EedghM8EzUwKo
         umVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705433732; x=1706038532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxJ9VvvDNT0D5B8Ol+QCsSG9ibygcO2/FPAnh3xxvBs=;
        b=fKTzXgQX9aXk1yBA2yy2iRLq5URJidrgybyqVmftrgt+rsdYg5GoSfOW3Kx9it5774
         LuFJrhTM4kr1RKhjB7euKYkKDYFeOvOkrQPMowhzg1y5vMqOM++1S8jO9CGGlIaKmy59
         LEsYfjOJJAL+G0ezQ/qC+NiGCaUdJMSbRmUMu0ZZ5wrEb3+GRkPGjoDkGltEIZw6dNI3
         IKoqESKKKOqThyq5yw1JCyQzL6lb3I27/AlglFNWI5m/5205kn8B7mrYjJkYSNLUIYW6
         4iCzFp50dulovVzDyams0BNwduSyVrHimenAM7uouh46155L+N+wgklz7/R1jQrlTXqa
         iNvA==
X-Gm-Message-State: AOJu0YzM/0YYYkeiOj7170CYaIWEgMAe0coWyz6GCYSfNljDJ9QwDwAo
	O7Bhmn9Z+tzn6oyh+M85uOUERh21wcjGqb9FYJawxL1gY1dU
X-Google-Smtp-Source: AGHT+IFuS1zhB9xcg19M4+HxcGo4M5RxCkGNH3OXYKC8ynWkrz+mknzKdyv/4JNGFL8c87QpTvtG6AK4R1NjfBJUBTc=
X-Received: by 2002:a05:622a:1cc4:b0:429:c6bc:330c with SMTP id
 bc4-20020a05622a1cc400b00429c6bc330cmr71651qtb.14.1705433731736; Tue, 16 Jan
 2024 11:35:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111234948.3103511-1-davidgow@google.com>
In-Reply-To: <20240111234948.3103511-1-davidgow@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 16 Jan 2024 14:35:20 -0500
Message-ID: <CA+GJov5HdYAaQYfM1=m=DZPvBM76c0hNhWuUKnWB833-=raOqw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: kunit: Add Rae Moar as a reviewer
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 6:50=E2=80=AFPM David Gow <davidgow@google.com> wro=
te:
>
> Rae has been shouldering a lot of the KUnit review burden for the last
> year, and will continue to do so in the future. Thanks!

Thanks David! Happy to review this one!

Reviewed-by: Rae Moar <rmoar@google.com>

>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f8efcb72ad4b..2316d89806dd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11599,6 +11599,7 @@ F:      fs/smb/server/
>  KERNEL UNIT TESTING FRAMEWORK (KUnit)
>  M:     Brendan Higgins <brendanhiggins@google.com>
>  M:     David Gow <davidgow@google.com>
> +R:     Rae Moar <rmoar@google.com>
>  L:     linux-kselftest@vger.kernel.org
>  L:     kunit-dev@googlegroups.com
>  S:     Maintained
> --
> 2.43.0.275.g3460e3d667-goog
>

