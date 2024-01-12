Return-Path: <linux-kernel+bounces-24962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C5A82C554
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E941283F49
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9781D17C91;
	Fri, 12 Jan 2024 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="flajn/Hp"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD017175B7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2d04888d3dso33173866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705083556; x=1705688356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4YgfB75CHcjxceeOnVR/ppUWGj8eZS3KKNzpvFvVkgw=;
        b=flajn/HpYNvQD5M3bnlvKUM10JgJNeDLoJVLIvHyoj8RrmFe5pGeVQRmUNE3TWCDF7
         q+32dYu6toUJ2f1HX45/LGc7l61LI6xVVpJTS610iavHmAQ8EfhN4USxLbLCvkg75Iox
         j/N0gk9vqrS2i9e4SIIAKI2bV0956bvKREi9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705083556; x=1705688356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YgfB75CHcjxceeOnVR/ppUWGj8eZS3KKNzpvFvVkgw=;
        b=FkSwXxe4YRFNVkq9XlK+M8NBa+OpaJzrlcF3c8t664E+9tetgH2K38NUrM8AHObfT1
         9RqCNHzfmfG67oLKPRqznJFA6QXlj8IVtVTGpKSRYziBuW6l3P3RPubCMTZLbPcMpOOk
         3T1PYmWl7VO5egXHBx96HUHWxUAfD8uWBWyxPgrWftrDNHNjbSSG/5i1kjPjfavUa50Q
         LXHCT4BHVoD/O4hhZhqc+fs/lL06IpfK0HoMtgNpufD9ECh5KTzjOYa4i4X4OlYOY4jp
         CwlhuW5AmW14pwZp5/pqoVIAWbNC0n71XUE3984T/mwXdGk2T2BslzMbPLK3vDnt7l2B
         5XEQ==
X-Gm-Message-State: AOJu0Yz6RWPHFC85O+RYq+3YVW2ds28nMRV/yO1t7oJN50kAi2u0a9mk
	TBzD8IFM9mcYJWGJjAiJiCKzN3HWFR1/XZXT3SjsbkWLYOuPBNf4
X-Google-Smtp-Source: AGHT+IGU+WIpugRRYz3pubQWlEZQ3btlN1RMn4U4FmkNcNuSxrivezn8JWUUTSLp5MVbGk7vzfeMGA==
X-Received: by 2002:a17:907:8b93:b0:a23:4e3f:a2fd with SMTP id tb19-20020a1709078b9300b00a234e3fa2fdmr1095111ejc.5.1705083555946;
        Fri, 12 Jan 2024 10:19:15 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id jp9-20020a170906f74900b00a29512c5ee9sm2031227ejb.154.2024.01.12.10.19.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 10:19:15 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-558ac3407eeso2220654a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:19:14 -0800 (PST)
X-Received: by 2002:a17:906:3813:b0:a27:f2c8:acd3 with SMTP id
 v19-20020a170906381300b00a27f2c8acd3mr803201ejc.94.1705083554611; Fri, 12 Jan
 2024 10:19:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZaAzOgd3iWL0feTU@google.com> <CAHk-=wgTbey3-RCz8ZpmTsMhUGf02YVV068k3OzrmOvJPowXfw@mail.gmail.com>
 <20240112071242.GA1674809@ZenIV>
In-Reply-To: <20240112071242.GA1674809@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Jan 2024 10:18:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjwL6bdmvdLu2CB=OmD3Dkr=ENATVsk6mE3rpZ-tavktg@mail.gmail.com>
Message-ID: <CAHk-=wjwL6bdmvdLu2CB=OmD3Dkr=ENATVsk6mE3rpZ-tavktg@mail.gmail.com>
Subject: Re: [GIT PULL] f2fs update for 6.8-rc1
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 23:12, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Where would you end up with old_dir_page != NULL and old_dir_entry == NULL?

D'oh.

You are of course right, and I missed that connection. Happily my
merge still works, just isn't as minimal as yours.

I see that Jaegeuk already posted the patch for the cleanup.

              Linus

