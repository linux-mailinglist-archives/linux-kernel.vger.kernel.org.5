Return-Path: <linux-kernel+bounces-34535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6639E837E86
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C9028EE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47F058ADE;
	Tue, 23 Jan 2024 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RAu/2CMW"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2312E56
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970647; cv=none; b=nHd53W1mGQdU9f7cMqo6Wl9D21QtnYijFiKZyvFrr0eBvE8V7tT+Qm/r1BOF/ktE2rWGgfTpKcbb3e236UTItk2hfoftK5sSfC0/j5+079jUzIsx53GMZe8PKNwr5cNvE1bVjf8Rot5m0n9nElqHcr1RpwlHuIngxtE2lyyatks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970647; c=relaxed/simple;
	bh=lqWnCn2DPBbY8g6aOwefG3Qz92nPQlx6pHEovITWs54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZ0ZsjdXdsyAqFf3ZsIfwoITCRs6EEFnwQyj48MeeLsPAZ3sZl5Ao3lydEBHNUV2ktbMMmrVR8FkePGXtURUEE8J9fnIJTcYdP9COYgQyGgeDhclNn0m+iPStkNt5Jo7U8i7+k97g+YwLfBQs7mjCD5ZAHhsDkClnGz4DsLKBso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RAu/2CMW; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2e0be86878so883800566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705970644; x=1706575444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8T7UgnjmQjulu6W4nl2ydx9Xz+2kAMCTenXm0NDaQtI=;
        b=RAu/2CMWEKlC6iaP1G+6YFe2WUUzz/IvxZeIfqBo9GqHo+hM+xa+/xHldldQheqN2a
         BiDM7jq7EORtyKJyUAJPBd5racEidzz5/u6wWTmOD6FzlT0izx0bnDObZI6vSvfcswav
         2rg7sQFl8tsXmtd2MN/ha6ysrRogWM0rbffFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970644; x=1706575444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8T7UgnjmQjulu6W4nl2ydx9Xz+2kAMCTenXm0NDaQtI=;
        b=jqeFcODTptaRehAMGuwEe+6tBx7RelbS+NEoma7GlhjpOoyfgJICtW2Jv6rRYuAu6N
         tykKORr7XE6qVATHCQgto+fBYqKhn+9ozaJ8QV7WNUL7MHc1KxnKD5bCqKQHrUluOJyo
         oDeEb2vOct0H2okSeZHXWi4psx9Gm8yUyU5X0BP2NRFbehSbLgfLYxJEW8+u36JrhXfq
         Gj0Gz9XN/KyXwktgITLu1ZDPbl1zBSWp2WVy77iggD6GQ+4jUzCHAdY2yNk4ENgz6JIv
         GwNvAqaRJkKeDQe0bwmHieB8eSWJN0dl7637LbhvZOKsYvR6NNi4uEzziGvEasplGcD3
         XB2Q==
X-Gm-Message-State: AOJu0Yzubnrm5Gofuh2yxVcXX/+nU8IseQQFZjHHPemmnb3ykK8o/n/e
	+GZjh0jZuT5B2E3KInW2sZVug4/JJkLjHe7lH1hordVrBpu8dBhRIFO/ODHrqBamJFzoxWXjan0
	R1eNPuw==
X-Google-Smtp-Source: AGHT+IE5YH6DYWaEOgMX9KKZBz4xKqJttCX8zwOTfqoLygW7mhXhIsS0BSHIYdi1Fn2eN65g2jrrtw==
X-Received: by 2002:a17:906:d146:b0:a2e:b015:edea with SMTP id br6-20020a170906d14600b00a2eb015edeamr4558182ejb.53.1705970644250;
        Mon, 22 Jan 2024 16:44:04 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id vx4-20020a170907a78400b00a2d62a515e8sm11038008ejc.212.2024.01.22.16.44.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 16:44:03 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-559cef15db5so8487609a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:44:03 -0800 (PST)
X-Received: by 2002:a05:6402:1a30:b0:55c:5154:7229 with SMTP id
 be16-20020a0564021a3000b0055c51547229mr743911edb.2.1705970643512; Mon, 22 Jan
 2024 16:44:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122180605.28daf23a@gandalf.local.home> <20240122181547.16b029d6@gandalf.local.home>
 <20240122181901.05a3b9ab@gandalf.local.home>
In-Reply-To: <20240122181901.05a3b9ab@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Jan 2024 16:43:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=whry+-JUDiiCkDkDn2TDg7SA5OvZpPbcQ_jkM_J5=ySdA@mail.gmail.com>
Message-ID: <CAHk-=whry+-JUDiiCkDkDn2TDg7SA5OvZpPbcQ_jkM_J5=ySdA@mail.gmail.com>
Subject: Re: [BUG] BUG: kernel NULL pointer dereference at ttm_device_init+0xb4
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 15:17, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Perhaps this is the real fix?

If you send a signed-off version, I'll apply it asap.

Thanks,
                 Linus

