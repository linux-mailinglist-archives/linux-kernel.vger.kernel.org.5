Return-Path: <linux-kernel+bounces-148382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CB78A81CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3151D1F22374
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C08013C834;
	Wed, 17 Apr 2024 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kBD5vgrY"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD796A02E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352411; cv=none; b=SOf5EWqRc/lYD5Gnh7N9BPuYF6L7NM0f2c5UVEQeUNOg3xGpJacAR/ermmiQXUCv0V9GejqDz6PixdHh2JpkRHllG7iKsfwCZRV+NkZu78lJ6lxBKig/MQxQML6GriKZUVWSKNxHXRQ4RBYShtQ11WCDQMKsGx8pwEYlp7CxqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352411; c=relaxed/simple;
	bh=IarwKMiznEy1PBPWGbQKxxJWvg2/aiKR3AMJhWHgSdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNnsXHrIkJPvkQItEnGCsvEKg2W2ERWauF64XWmvi4r3n3kcp3DaTyaxFKi0sLbKaGfL6NJNTixlWMz6mZZYbd1d2taS9XgLs4iE9zZ/3YgaglbaOxgfnpFjyESo8O0ipiCGN/gwHAeRrywZE/wpW+p6RKOZSNX8GeQhp5VQ7Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kBD5vgrY; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61ad5f2c231so37353427b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713352409; x=1713957209; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2/YlYSS9grR85lTUsIz5s8zbmJslDTa4bnvdCNONPRc=;
        b=kBD5vgrY+yxC/ysHRS2W4YEFt8La0s5TLdd5JVtzgvfWauQt6qKNxaO6SMAJzxF+iM
         D8YT+wR3zl1EFvsnLpBLhT0nJdIKLPi5SYHmXHQULwGkEEQMoXZqm7z345tPpzHogMiT
         Lv7juUbficWRHDE7TtceRMuX/dSD6selNmi6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713352409; x=1713957209;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/YlYSS9grR85lTUsIz5s8zbmJslDTa4bnvdCNONPRc=;
        b=ihBn/aKo7vZU2ikNX8kVYEul18ancHGiu6QfLq69QJmc2/+SaBtSdqI/sbquKjePka
         HdimELPf3w19PWRitaiO9DuIzs+peKv9lgzhLWf9zXYfOw7Q6vAuULOK0NgKJlZD0KZ1
         ZCSLCXSZ8klmSA+neCHpdyZWyBx5AaDhlmI4ebvxbxyozSZRel5YTa7tAWjyGzFT8dq3
         8NDdylGWICX0dFmGYb7zM9HLAG4u/5XQ0bhWrWAl/DX1TDl2/X1DXPFNny7DHg98h0oQ
         6Y7jr6YtES/pVJlR8cHBaF9SNg69sewhl/m6OPW0ylofg0dWOKpzOu0QOCVU3Cp8v49K
         hcBw==
X-Forwarded-Encrypted: i=1; AJvYcCVN77vcUxKvH8851hCwW6OwV6qtuJ0YeflPwtrc7kEiGT3cPPuFEH1WlZFTQdQY00ti5su2SoTrkU3iG2B/Agq00eGPNA+RniHvYy/p
X-Gm-Message-State: AOJu0YweJHJuuPtHaeE6rzz0ZHa4tLZu/aFJgow+UQ19t/dhy7yVrGGW
	h71Wg8XJuJzRRnKP7QXaqdfpJhOlR7T/3V31GwiAsKCJDJ2oYZhBB7S3mMtESAPmFH4j7xLl6Ho
	82Yec
X-Google-Smtp-Source: AGHT+IEmMXw66U3QEKB736TaKkrEqKid7gSV/5POb+02fZWZYHvifN4RnTWG0y77E5lSwyBpH5vpNA==
X-Received: by 2002:a81:4e0f:0:b0:61a:d0f4:326e with SMTP id c15-20020a814e0f000000b0061ad0f4326emr7564968ywb.33.1713352408737;
        Wed, 17 Apr 2024 04:13:28 -0700 (PDT)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id i21-20020a05620a405500b0078ee852d769sm3209857qko.52.2024.04.17.04.13.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 04:13:28 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69b59c10720so22530836d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:13:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfmLlcVWuqzTg9QOj/2LM3PldVAwpYooW/1A2XvFtbRpiXuhGGqEZ6cHAxTOGwQbiZfpz9q/n6VmuhM9PfAdt+rWYHG8RSCbHdjove
X-Received: by 2002:a05:6214:704:b0:69b:5c57:362 with SMTP id
 c4-20020a056214070400b0069b5c570362mr12445414qvz.1.1713352407112; Wed, 17 Apr
 2024 04:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
 <fbf22b53-7b68-4e60-99c7-ab38a77a53c8@web.de> <CANiDSCuvXvjfhw2mjSef1wR8RiL=9KrDEoh+3o1ed4+8P+AqGw@mail.gmail.com>
 <60df00eb-41ca-417f-8b8b-90dba6eaaf65@web.de>
In-Reply-To: <60df00eb-41ca-417f-8b8b-90dba6eaaf65@web.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 17 Apr 2024 13:13:11 +0200
X-Gmail-Original-Message-ID: <CANiDSCtZzAs0u2tqJGRaJz6iqCTu_p-j_rkyGU7a9HFqUbJEMg@mail.gmail.com>
Message-ID: <CANiDSCtZzAs0u2tqJGRaJz6iqCTu_p-j_rkyGU7a9HFqUbJEMg@mail.gmail.com>
Subject: Re: [PATCH] coccinelle: misc: minmax: Suppress reports for err returns
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr, 
	LKML <linux-kernel@vger.kernel.org>, Denis Efremov <efremov@linux.com>, 
	Nicolas Palix <nicolas.palix@imag.fr>
Content-Type: text/plain; charset="UTF-8"

Hi "Markus"

On Tue, 16 Apr 2024 at 13:50, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > I think errcode needs to be executed in report and in patch mode,
>
> Adjustments for functionality of coccicheck operation modes can be clarified further.

https://lore.kernel.org/lkml/2024041643-unshaven-happiest-1405@gregkh/


>
>
> > but there might be a better way to do it.
>
> Corresponding design options depend on varying development efforts and resources.
>
> Regards,
> Markus



-- 
Ricardo Ribalda

