Return-Path: <linux-kernel+bounces-147810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2133B8A79F6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57A2BB2132D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C248517C2;
	Wed, 17 Apr 2024 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JdRuxUQK"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9CF64C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713315057; cv=none; b=MPlDKqTsMUXJxGr+VluCmkM+8sqSlayq7Q6vlYb50NWMbyUwhFacK8a0DvC5s1O24ktd7pWspsNi62EFp29gaGa4IVtQjJ9CvsHqUxJL7tx/I7RekpBflci0UFJCmoB7kfazKxT5bEpqJvq4HTjXwjdzUz2q8HszuBxWhR+WZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713315057; c=relaxed/simple;
	bh=tEt2neeMhkJXYowSS4zB7i8JdZKZdQzPkmTlL+k4K3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1JUoBtZ6eFSpxsD/7k6RQkq70dnRVs5Qi2tSmq+HSCVHBQKK3UPWJPsxtJDqunlHncpoCeRA1CKdn3slEahgF13IbpAEQ2Y5X5y8wr5mqJoBdkYCpf0s5SQuoDytCzNVaS6Kfuwrcznj2CZA6UiQvGvKydg5URk4dmLH6QHA/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JdRuxUQK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56fffb1d14bso464524a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713315054; x=1713919854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PjW0bA9YFlwaYeRZXTpCY+jNWdxFSQw1M095VHBp3hc=;
        b=JdRuxUQKHYThPXpqdyp50bU1bQYwsfDOVQioFlI3EbNKCsmyeATqa9O+tJpGeQl37g
         ODNimBiNKOlRvk/D26tYyyEZpsz7X0ummDq8fjKwtWdPeW40FcNF9l7wtnnSwXgxO8UV
         +duEUF4NYrXjtpczIPdq7IlHbX9wjUYrPXvrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713315054; x=1713919854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjW0bA9YFlwaYeRZXTpCY+jNWdxFSQw1M095VHBp3hc=;
        b=C3PH7qc9sabVjpDd+4Zwv5i9W3PBYw5hZLQpO58dyeijYg39yM2cq5+BI1bcYIfA2B
         JcUv/lW7gffePcW3soEMOooPzvYAxZ2X2AMnpsAuRQWNm50HgjyV+6SC6bkotnvgoEK0
         M1XSgHt5nJfkSkbACZBzFDV8RhHpkopNGOXhVdPsIsWNKP+5sHxVEtN6owAeGiZ5srrr
         aYITYQVopDgA0YEGURFmO+S4mA9Zhfum52zfwDBlQAEQZEMazExLJLNhKBLkW8Y9dV/I
         WjXIW6zfefuIQF073BWZP/0B0y/pGzQRvL3JXTkkHH/KxI3o+fbU48WPdfpI5wnMg/2p
         ihlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAoFSBY2CX+2/VNCGgbbN7SSMNmTRk7E6pUSU1DMQZMnzAa0HRvqOqtVop8Ivt4Ry0Q0/9DjWb+f1duiwhHbRBo/6ejkDQ2QEpBV8y
X-Gm-Message-State: AOJu0Yz+KrrfUEEn80EJ8soB/OHTcT1JtrHhzT+daAC0x7O//nIh/3QW
	niXD0VaoczDqy9WrxEU2WWAKaUh8UsYn5tcNsrP+WeyBIj15+JlvAt7XjAxysO+gdalfFcR2x74
	IuLg=
X-Google-Smtp-Source: AGHT+IFnvsbt5KgBk65y/jAvklBb5Pqh4bzhmulLw3gfYan13slJYdTOM83HX1MPlpLmgPrzwahyWQ==
X-Received: by 2002:a05:6402:f0c:b0:570:17a:b1f6 with SMTP id i12-20020a0564020f0c00b00570017ab1f6mr4031043eda.6.1713315053904;
        Tue, 16 Apr 2024 17:50:53 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id t6-20020a056402020600b0057030326144sm2577140edv.47.2024.04.16.17.50.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 17:50:53 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a526d381d2fso53879366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:50:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWy39YZpXtgxSRFwoH1AWD1hw4bchHl2C0daxwqTAYL7NzW7UkLZlCjjbku5a+6AKmjLyw38ttuGI8Pc2MAvVBgKzfJVolLC68BE3L3
X-Received: by 2002:a17:907:97d1:b0:a52:2a65:cf2 with SMTP id
 js17-20020a17090797d100b00a522a650cf2mr4838164ejc.13.1713315052778; Tue, 16
 Apr 2024 17:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220302043451.2441320-1-willy@infradead.org> <202404161413.8B4810C5@keescook>
 <CAHk-=wg7+dfpEvDnTnB-eR9QRZ2VySbxOEHbYqL3Ai5wwkon5Q@mail.gmail.com>
In-Reply-To: <CAHk-=wg7+dfpEvDnTnB-eR9QRZ2VySbxOEHbYqL3Ai5wwkon5Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Apr 2024 17:50:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizMKBPZeOy7UiQjNR5Jm103WNzL4sHq4FpZihk7yBsfQ@mail.gmail.com>
Message-ID: <CAHk-=wizMKBPZeOy7UiQjNR5Jm103WNzL4sHq4FpZihk7yBsfQ@mail.gmail.com>
Subject: Re: [PATCH 00/19] Enable -Wshadow=local for kernel/sched
To: Kees Cook <keescook@chromium.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 17:29, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So what is the solution to
>
>     #define MAX(a,b) ({ \

Side note: do not focus on the macro name. I'm not interested in "the
solution is MAX3()" kinds of answers.

And the macro doesn't have to be physically nested like that.

The macro could be a list traversal thing.  Appended is an example
list traversal macro that is type-safe and simple to use, and would
absolutely improve on our current "list_for_each_entry()" in many
ways.

Imagine now traversing a list within an entry that happens while
traversing an outer one. Which is not at all an odd thing, IOW, you'd
have

        traverse(bus_list, bus) {
                traverse(&bus->devices, device) {
                        .. do something with the device ..
                }
        }

this kind of macro use that has internal variables that will
inevitably shadow each other when used in some kind of nested model is
pretty fundamental.

So no. The answer is *NOT* some kind of "don't do that then".

             Linus

PS. The list trraversal thing below worked at some point. It's an old
snippet of mine, it might not work any more. It depends on the kernel
'list_head' definitions, it's not a standalone example.

---

    #define list_traversal_head(type, name, member) union {     \
        struct list_head name;                          \
        struct type *name##_traversal_type;             \
        struct type##_##name##_##member##_traversal_struct
*name##_traversal_info; \
    }

    #define list_traversal_node(name) union {           \
        struct list_head name;                          \
        int name##_traversal_node;                      \
    }

    #define DEFINE_TRAVERSAL(from, name, to, member)            \
    struct to##_##name##_##member##_traversal_struct {          \
        char dummy[offsetof(struct to, member##_traversal_node)]; \
        struct list_head node;                          \
    }

    #define __traverse_type(head, ext) typeof(head##ext)
    #define traverse_type(head, ext) __traverse_type(head, ext)

    #define traverse_offset(head) \
        offsetof(traverse_type(*head,_traversal_info), node)

    #define traverse_is_head(head,  raw) \
        ((void *)(raw) == (void *)(head))

    /*
     * Very annoying. We want 'node' to be of the right type, and __raw to be
     * the underlying "struct list_head". But while we can declare multiple
     * variables in a for-loop in C99, we can't declare multiple _types_.
     *
     * So __raw has the wrong type, making everything pointlessly uglier.
     */
    #define traverse(head, node) \
        for (typeof(*head##_traversal_type) __raw = (void
*)(head)->next, node; \
                node = (void *)__raw + traverse_offset(*head),
!traverse_is_head(head, __raw); \
                __raw = (void *) ((struct list_head *)__raw)->next)

    struct first_struct {
        int offset[6];
        list_traversal_head(second_struct, head, entry);
    };

    struct second_struct {
        int hash;
        int offset[17];
        list_traversal_node(entry);
    };

    DEFINE_TRAVERSAL(first_struct, head, second_struct, entry);

    struct second_struct *find(struct first_struct *p)
    {
        traverse(&p->head, node) {
                if (node->hash == 1234)
                        return node;
        }
        return NULL;
    }

