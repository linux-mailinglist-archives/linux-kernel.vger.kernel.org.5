Return-Path: <linux-kernel+bounces-133541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE4189A54A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C961F23150
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B932173341;
	Fri,  5 Apr 2024 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZHxay92"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0530315F40B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347066; cv=none; b=q7JRlLfRqlJXtILEyaJ4IXmtazBHPxv8FQ35g0f82Jjq1pUSQXF4qYd3o8a5tAzemT6nY7uj5cbV0OSOCPzAOdFZLDUUlFVEnCYT5/GousnYDZrLI+6u3gOFXrrce4BKu69l7Zqi7wzJTMQy2f1LOy7p1QwPBy9Xd4x8qf2Uy7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347066; c=relaxed/simple;
	bh=i4aU/UJRGWn3roF1gYrAQyoBo6RFX+MLKL0nbEEnYFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFgD7svHLnsXcK7QmKlsSVUyWw4unSou7B2p6y7hp/cH9R6/MIkeTNV89aKfAQjF2YkEcY7sS8EyTYxQnxrB27/QdQbK/i1zNF8sO2/d9+2pGE2vcijHZv+Qi9KzBjHT4XrIM7RODnL8PQefQcJVgYgxVbZzlEJdtVNRaGjHmJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZHxay92; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6962a97752eso17215466d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712347064; x=1712951864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4aU/UJRGWn3roF1gYrAQyoBo6RFX+MLKL0nbEEnYFc=;
        b=JZHxay92Sg86m2wQMO4K4uFqm65LAlg6+zEdKkdRGfw7ICxd/B9zQuek3EcTthIQq6
         6/cEDDhaTVvD0xtgPC+qaK07ZfHrO684Ii0b4GUMm9qKBIiw/GbehZ+YH8nNz1OFjpg1
         jrLym18HtBTdr79IKjgEfBo1wyookIsJOHnxj/Iz3WguIVIfczV+42UlSxugTdd8mwHd
         ncPcrKnfKT25KPSBl5oIc4ecJsL+YRwGr5RklzsoXfugMsrCUn5gP3xcq8I8KCS7D8qF
         RLGP7L2P5nce3N6Ck7U1FsR7DEUgFDkiohvh5b5ttOl8La7npB54BJPh32PBFXPF6rp4
         0Ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712347064; x=1712951864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4aU/UJRGWn3roF1gYrAQyoBo6RFX+MLKL0nbEEnYFc=;
        b=g+LlBc7wAL56ve6bm4IFvbQHVI5PnrY2MA8fxuK3rhuKhV4yim0GgkQpxCUtldE3xx
         xO80LOgTeByyaAG1bZPrzL4wweidrvkwZhOVi7vF9HBUxEdJM+s2oKgQZ3itOVSLxtT5
         WH+Ngi9/O4uPIMMlKWZHUP1PUnHjFJyWQ67aqFuXnPEx34MtVdPcOQ9SwONVoXnjGnS8
         NzWR5Wt9tpOVpPFPLOG8c+JkOVIadeoW/KeF1GFih0QJP46dO9KpEmtqJS0HsLfM5Go2
         R7j6xXX198rM/QR3mcU5kHNoXLAJGZ8JqgWPiwbd3wpUU3uSznI/i5B8o+sy+GweUxlY
         I04Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcAdizzZfVl+OZz0KEZsLuPS84HwvQW0ekyG4rjcDTBRRCwZS1aYd/qmnpLhozCzB9ZqTGLy7MVrOHh7hLXfASuBsngocT1u3ZWjqr
X-Gm-Message-State: AOJu0YygIDB13u5aepnsVA7K9OnzLjcQsNzCw1XvNadxj1JXq9WK8vGx
	8we5rOI1X0S2XgcmrMJ/JDrcbwuwWuBMG8IMPm8kLcRbi2obS0rQjvlkMtlBm6fyBLuf3/u62Z9
	2C0u1RaebAZ8xyZGiue9NLmQFYG4=
X-Google-Smtp-Source: AGHT+IFvOGEBh46q3rZivlR1LP+lSeeLx2CeRARRGod6UCZzgO9LQrKt7fakn8isiINl08uRWcvtPivkSTlFNiXY2jQ=
X-Received: by 2002:a05:6214:246d:b0:699:3f45:44ae with SMTP id
 im13-20020a056214246d00b006993f4544aemr2973295qvb.6.1712347063962; Fri, 05
 Apr 2024 12:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405053510.1948982-1-yosryahmed@google.com> <20240405053510.1948982-4-yosryahmed@google.com>
In-Reply-To: <20240405053510.1948982-4-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 5 Apr 2024 12:57:31 -0700
Message-ID: <CAKEwX=PMBUVyWwzc-8-+3ukmWekzwqsOq1dAEic9t4A+LKEe4w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: zswap: refactor limit checking from zswap_store()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 10:35=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Refactor limit and acceptance threshold checking outside of
> zswap_store(). This code will be moved around in a following patch, so
> it would be cleaner to move a function call around.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

LGTM.
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

