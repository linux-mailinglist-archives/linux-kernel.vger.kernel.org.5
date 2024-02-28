Return-Path: <linux-kernel+bounces-85715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9F686B9C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081741C224D2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABA970036;
	Wed, 28 Feb 2024 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B+m69ozj"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7B8627D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155290; cv=none; b=HmefSMwS4NyK11e8KnmuJNfKcw0bQFg4qj04cPBtJCi1suFXG5Elx5UV+8KeLqzcq0Wu6bN7tTFiX89P0RIG5PbmHrZrTR2Kkt+98DP+zK90bUFJw+fIMk3VmRT5OosKZHPrOf15kBc0jRUsh+nkdxcVgIgjXn4JIzR8FIENRN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155290; c=relaxed/simple;
	bh=1MRLxMSSbDaZOoH74gZrRBxdj01ORAzox/zNSSQV35k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zah6hcwvr1/LSJeiroKk8NYEygNjrg8fwBmkTnMRWPJ7hPLJC+SucmvjEwPpiwvMqJsDBlE7Taxo2I6anMvms9cslUODHcm2Q9NQKCWPl8nfIejadWolee75ypC/qEowUPAyYV74KnufxQIHsjZqNHS0O/eUBh9nZHKdVNRs4pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B+m69ozj; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a43488745bcso37828266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709155286; x=1709760086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ibURPhL0TwbuNHb2Ue6c1VsEM5dnOByPcep2Xd5k/OA=;
        b=B+m69ozjwNePNGkNIqZxY5cYxPT5xZkc2iYa3mL8hTrYFU1YOYVnRJsPkJqCi2ymQp
         hTWjmaksS/HCeGz5kk/DM0ms6EkmbZ5//kAhxkq4/NA3lQz8y8UqCP2WwQMif4pCIbFR
         Ue6ZGIY3ca0Oo0WS8pFOfA50DMxhF4102kkC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155286; x=1709760086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibURPhL0TwbuNHb2Ue6c1VsEM5dnOByPcep2Xd5k/OA=;
        b=oH8UP2TdE5bb3sRlwjixXGzP9mDF0jWE5wSJ3Hnj1USNCbobf9X5bgYBS8wbT+KLcR
         +OSWjmFAjGF4a8wH+tm03ZCjlWZiv7yXjNmuOQN2Qbswy3WrBlZGRCoi6PfkwNdI0ejY
         Pwb1zb8gPTFzVXczDtqsFwTPCrbgSemWgftzBZ9t9WnH/LJmsRmL3hYrigxDMd9TbM08
         QSmC4mthW/6MYCFZjmuc0Cn826IQxDYjejUSMijBOHozNXhBdjUvXomo889xyok92d/b
         wH5Pp5+ebvKaU3PniKbDQYbeG3JTMMWdM/5PLVrrX0QyHYgCbo/IRGAzuzOi7+l5rY7Q
         hIpg==
X-Forwarded-Encrypted: i=1; AJvYcCUvpyi/Wf+if9BRa0R6s5wBjwcXR4GQoA30Nehos5nvDS4kxjcOwHT1PR9BLFmdCAAD2IGDVgfxp/wgo5/5t4YANSHgvpWMAhaOO6Jh
X-Gm-Message-State: AOJu0Yy2w+S+NGaYLJb4WFk61iEnpgG4j2wV1VAJPbwfLEyLIMKiD7A5
	rQrwpBlIOjGmDQDbotxmnSMOCpXLcq/aGiRMj7GWg/0cZFQiv1e29neku+RAVPL4jFZF5aLyKHf
	Jsp+nVQ==
X-Google-Smtp-Source: AGHT+IGoR8WcFnrOwrE+RWoBbjvTueUnz/S7vn6s1BHF1wyo0DlaT0YyW2gvGqh4SMdu0UeIRJ+AjQ==
X-Received: by 2002:a17:906:f8d5:b0:a43:6156:6e75 with SMTP id lh21-20020a170906f8d500b00a4361566e75mr126547ejb.43.1709155286385;
        Wed, 28 Feb 2024 13:21:26 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id hu21-20020a170907a09500b00a3ed975968esm2243680ejc.28.2024.02.28.13.21.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 13:21:24 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5656e5754ccso361023a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:21:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVip/omivsvQxQgD8+b1laZSMj9Ce/hjpZF1Kvr/S5UjFqLvHhTHwVZhkdQSW+e1X+o/9fUAMren5TjiMY6rfUoSLe1qBsLJORdVFZE
X-Received: by 2002:a17:906:a291:b0:a44:234:e621 with SMTP id
 i17-20020a170906a29100b00a440234e621mr129720ejz.10.1709155284453; Wed, 28 Feb
 2024 13:21:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com>
In-Reply-To: <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Feb 2024 13:21:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
Message-ID: <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <christian@brauner.io>, David Laight <David.Laight@aculab.com>, 
	Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 19:13, Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> After this patch:
>    copy_page_from_iter_atomic()
>      -> iterate_and_advance2()
>        -> iterate_bvec()
>          -> remain = step()
>
> With CONFIG_ARCH_HAS_COPY_MC, the step() is copy_mc_to_kernel() which
> return "bytes not copied".
>
> When a memory error occurs during step(), the value of "left" equal to
> the value of "part" (no one byte is copied successfully). In this case,
> iterate_bvec() returns 0, and copy_page_from_iter_atomic() also returns
> 0. The callback shmem_write_end()[2] also returns 0. Finally,
> generic_perform_write() goes to "goto again"[3], and the loop restarts.
> 4][5] cannot enter and exit the loop, then deadloop occurs.

Hmm. If the copy doesn't succeed and make any progress at all, then
the code in generic_perform_write() after the "goto again"

                //[4]
                if (unlikely(fault_in_iov_iter_readable(i, bytes) ==
                              bytes)) {
                        status = -EFAULT;
                        break;
                }

should break out of the loop.

So either your analysis looks a bit flawed, or I'm missing something.
Likely I'm missing something really obvious.

Why does the copy_mc_to_kernel() fail, but the
fault_in_iov_iter_readable() succeeds?

              Linus

