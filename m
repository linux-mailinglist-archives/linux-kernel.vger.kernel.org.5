Return-Path: <linux-kernel+bounces-24301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C36782BA99
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527391C24F23
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6675B5C2;
	Fri, 12 Jan 2024 05:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CmwWBTWs"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6D35B5BA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 05:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50ea9e189ebso6750649e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705035970; x=1705640770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dXyIUVvSUCL/muzqemPrKFvk+YTfDh6SV30EeEyNy5E=;
        b=CmwWBTWsL1EkD5H3GMB/rObiHuQaGjKQmpH2uqAP6NFzuIQNVHgACtXTVMRw/f/vbX
         n0kmGXjK1L7h2tjyX70SoJEP/bZ+wbR35tW91QaEE9cPBiJVTnWIhGHjTcBfhljldJLE
         1OqR5iYXYseYhOL+Jk5SXS69+KcdEE0BTXYqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705035970; x=1705640770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXyIUVvSUCL/muzqemPrKFvk+YTfDh6SV30EeEyNy5E=;
        b=VjM4Mm7utkIxBtaH4q06BsZRJya784IzpHi1CfQ4lO8Ay7gakuJjyQ3CcXl+C3bFz5
         7BHWFvDU0RVpSA6Egb7QL6seKrsQQFzHlNDFRZyolxdK2BJFznVU5363MRabbDNVkDBf
         l2ywRSZhqw5MO2AqXBZrHDmI9Zpe5ITDUqryVtXattAp8dl+cpM1SchA9cLbqhsiYOCJ
         2PdeoGE6XjVOfn1wDXc3UlNjx64RKytcZgLQoKPHIjZlLqjuIClP8pypErudpdd4qUbG
         ab/H4ANr5S5OrdeRZMZuuy50z8XuXnYWT5F5wdVIDZh78nvnuYSXFDDc4qFhEdhgdB0H
         dfYg==
X-Gm-Message-State: AOJu0Yx8Lrh70V9QQA0F69oJg/nhydvi7zRCrsmGWKoBhN9eHhcEHSaK
	Vz7JW5j7I/6r716p/hvYh5cSWQpDR4w7uualqSUVOxrI6IvybhKp
X-Google-Smtp-Source: AGHT+IF9vWFMnOv7BLS5jI/hrXr9aucGweXbkFDSoD8H2XUbGUnHLZ/qj7gJ6ONyYNsVBoegI/QYog==
X-Received: by 2002:a05:6512:e81:b0:50e:416d:c1cd with SMTP id bi1-20020a0565120e8100b0050e416dc1cdmr421562lfb.23.1705035970051;
        Thu, 11 Jan 2024 21:06:10 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id ij9-20020a056402158900b005583e670df7sm1332354edb.73.2024.01.11.21.06.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 21:06:09 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a28ab7ae504so585788366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:06:08 -0800 (PST)
X-Received: by 2002:a17:906:f345:b0:a27:c453:8706 with SMTP id
 hg5-20020a170906f34500b00a27c4538706mr303288ejb.125.1705035968579; Thu, 11
 Jan 2024 21:06:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZaAzOgd3iWL0feTU@google.com>
In-Reply-To: <ZaAzOgd3iWL0feTU@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 21:05:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTbey3-RCz8ZpmTsMhUGf02YVV068k3OzrmOvJPowXfw@mail.gmail.com>
Message-ID: <CAHk-=wgTbey3-RCz8ZpmTsMhUGf02YVV068k3OzrmOvJPowXfw@mail.gmail.com>
Subject: Re: [GIT PULL] f2fs update for 6.8-rc1
To: Jaegeuk Kim <jaegeuk@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 10:28, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.8-rc1

Hmm. I got a somewhat confusing conflict in f2fs_rename().

And honestly, I really don't know what the right resolution is. What I
ended up with was this:

        if (old_is_dir) {
                if (old_dir_entry)
                        f2fs_set_link(old_inode, old_dir_entry,
                                                old_dir_page, new_dir);
                else
                        f2fs_put_page(old_dir_page, 0);
                f2fs_i_links_write(old_dir, false);
        }

which seems to me to be the right thing as a resolution. But I note
that linux-next has something different, and it is because Al said in

      https://lore.kernel.org/all/20231220013402.GW1674809@ZenIV/

that the resolution should just be

        if (old_dir_entry)
                f2fs_set_link(old_inode, old_dir_entry, old_dir_page, new_dir);
        if (old_is_dir)
                f2fs_i_links_write(old_dir, false);

instead.

Now, some of those differences are artificial - old_dir_entry can only
be set if old_is_dir is set, so the nesting difference is kind of a
red herring.

But I feel like that f2fs_put_page() is actually needed, or you end up
with a reference leak.

So despite the fact that Al is never wrong, I ended up going with my
gut, and kept my resolution that is different from linux-next.

End result: I'm now very leery of my merge. On the one hand, I think
it's right. On the other hand, the likelihood that Al is wrong is
pretty low.

So please double- and triple-check that merge, and please send in a
fix for it. Presumably with a comment along the lines of "Al was
right, don't try to overthink things".

Hubris. That's the word for thinking you know better than Al.

                Linus

