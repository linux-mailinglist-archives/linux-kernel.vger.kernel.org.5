Return-Path: <linux-kernel+bounces-66934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA368563C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FAADB26A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C8112EBEB;
	Thu, 15 Feb 2024 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2O57R+XM"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3820B12DD94
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001665; cv=none; b=JGfrFsmpvJy4/gnWYVpzw4SbTr+HRvi+oKmpeHqdq8n/SG9YxF+WT9TirLC9ifjGU1grmFund+T0r2URHgxatGV6gl9jnjYf2saOSaI/6t2lYveIeWZzMTopoAF1vp/pewwd6ZwIgSOfVwes1qQstq6AY5RiPixM2YAhTtcJ0+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001665; c=relaxed/simple;
	bh=ArhHyn/D3f1E+tj2caV8bkzHL77hxClMdCwgtso6IUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqoERnZOww2baf4/IjzmPYBjI2KHeTL2VsNZZ86NrJfUyN6nTrq7A4YLkUSnpSO5ZBH7UkoGcMDucP+DU4COj70XgW9jfKC8lchv46EdZThc4khWmDaIsXSTxlGtLpL1DYMQ/9NpdGIRpQI7xhzSZg2xeXrVol3oOgYW8MjD+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2O57R+XM; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d2a78c49d1so448712241.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708001663; x=1708606463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ArhHyn/D3f1E+tj2caV8bkzHL77hxClMdCwgtso6IUk=;
        b=2O57R+XM+Lr6dh3IBReev0tLqOqJb0jfy3gwAyigP/ReJoZlg5SJmr8yG2N3bXMkvA
         nVLXinxC4QoOn2OOk+pkvHCyYY5+URopVCSjy3hY03SQgq435LDZh5fciVMLdF/N9NLQ
         jpVhrDkrvtuVhBMQJMILoaLWTJoF9bLp8QI7WiletCY84oRSZAVlqG2b5GljJbjFfQ9X
         lE9uHJBeW/BO+ukdd2gyafgks23JHxj8+iM40pjAdp3rMbsKLM+AYM2j/m0GYiHxy3cG
         xQP0uOTlWTUcLBAbEYinghUzSsTtj63iMvRMjveY1JRpUfbf+WMTpgZ8rpcHx0/0E0xP
         aemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708001663; x=1708606463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ArhHyn/D3f1E+tj2caV8bkzHL77hxClMdCwgtso6IUk=;
        b=Vjy32LIds30VufmTX8UdbXEHTT9Pq9XJV+2MLTCDDefKigT1izUHxsnNLm6hJmpN2t
         wpm+bg52VzXIK4zVW/TXxttv/f+C1P9MZfOG2ETgglec71rl1Ee/wt5uy0TAjHYkKb5l
         YIHceFJYKKfCsH/wQnqkHhV1ibLgW0IVKb5fp1vSrK9iV2qypyxCDwVt2waU9IMTVxGS
         AhO3Ma5JTkqU2IDoBSjVkozX6KUm4TbsqT9S6KHu2ZavYA0QCcl4kfflYUmjKW3xAg+w
         xrb2RgV+mhjJvyN6xosIIAHOgH9nanYu6cT9r716DHjRLSW2r8SERDV9a0SWiqYNlO8Y
         Agkg==
X-Forwarded-Encrypted: i=1; AJvYcCVOD7GKPfBWK2xHnVNc/PgAAdt6TIRIHyAamh04YxKPK5ykmGIB8IpNaWpaA8NGbDoeAFS9WoSCdLqbhdFcNq6KVE3J/K40OTH21IgE
X-Gm-Message-State: AOJu0YxS4m9ONVybwMUiH5kvGYlOiqRC8OieUDARdHq4pbjX0CVSGnff
	ggEkpGdEjc60ykKYhupMTHvqaLXt3yzJIcj2jxEFCW+2JXesQWUbKKrryW2Lre4jpZE8ws1te+z
	YUicoaeJsBh9iGnV4ut2w6bi1aQK7K9CS9bHy
X-Google-Smtp-Source: AGHT+IFBu9var6QUGs3Tcjxsjb+/eMH1i8gZt/k72FUDM6Yiif/uAQ9zCOOW01GRNl8qOjcRchVHIEe58Sy0QyTD+uw=
X-Received: by 2002:a05:6102:5089:b0:46e:eb29:7ba6 with SMTP id
 bl9-20020a056102508900b0046eeb297ba6mr1013277vsb.15.1708001663019; Thu, 15
 Feb 2024 04:54:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214170157.17530-1-osalvador@suse.de> <20240214170157.17530-8-osalvador@suse.de>
 <b730fdd3-7c7b-4790-95e6-63f0792c7f50@suse.cz>
In-Reply-To: <b730fdd3-7c7b-4790-95e6-63f0792c7f50@suse.cz>
From: Marco Elver <elver@google.com>
Date: Thu, 15 Feb 2024 13:53:46 +0100
Message-ID: <CANpmjNNaROhCP81Hp4Aee+8cMmqJBXRTxqcKawxLBBigU2whHg@mail.gmail.com>
Subject: Re: [PATCH v9 7/7] mm,page_owner: Update Documentation regarding page_owner_stacks
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Michal Hocko <mhocko@suse.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 12:13, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 2/14/24 18:01, Oscar Salvador wrote:
> > Update page_owner documentation including the new page_owner_stacks
> > feature to show how it can be used.
> >
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> Thanks!

Looks good:

Reviewed-by: Marco Elver <elver@google.com>

