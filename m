Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CCE7E710E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344795AbjKISD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKISD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:03:26 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D86A3A92
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:03:24 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so15335a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 10:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699553002; x=1700157802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAQNSa46FGuB0h3uAi5/LZq5ypqo1lqwzPUkOnFCUXA=;
        b=gd6Mtr+c+Oj0QZfeDiB/vbhX4I6pxbU6Aw5AcXaSZ7S3UnlFEhqkTXCoH4jlzzTC1B
         Y1l1umqUroZxqKpMl1AlIydyVOS/f79EkdxDvn8lDGe3gqi76J1BwtDvE+BHlhyZhsJW
         a753xYv+kr/Zq3g1FF+KxTlqoAaNviTuBVbIo/qoFyExGHE231vWSocB9vCILz/oxodf
         HjhU2/kcUcRSkPzc6LMJSpiE0tzv+l8cocACqm65E34/chy2s8cIHLECgxtezi2E/kQm
         2efxVnhc1wxwIO4o1jti4n+HKzfpknEdc7HfZqmLNF2c16jI7QivQ9sieecb8flFu+uF
         40Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699553002; x=1700157802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAQNSa46FGuB0h3uAi5/LZq5ypqo1lqwzPUkOnFCUXA=;
        b=YB7pNL8UY1ZkqQq2bxjmHhex08ACUGtoC9Rk0wjTwIwsEY+7a7LMAwqqPQ4MgLe9dg
         BQQTsiU3JpcBu69siqIPB+4/sd+R9Wl9+s1c3J1PFbv+JPqNAvhZUlE7GVHFzxIzNJ9p
         kfhFOlXTjOpckR+vXZ2bIo28QlkdmkmKP9tK4cRbp7rYY54zFjGlNHq4tHMRLhM7tlbQ
         Z8NTajzSkpb8w2+BD7FQPFROKv7nPnWo6vYyhhpbmKR5FVRaH9wsPoMP8aGEcpqbtWFR
         uVtahPDH5QXgmJAmDBZKrUIIc+hn4xn2/zYcOE0o/LzQRRMU+GU9NwodvUkRI6Gluchd
         foIw==
X-Gm-Message-State: AOJu0YxfL802R0IvzwuJxHQmOyCw/2z4DX7GKR27sTGM+4IAD8NLdpoS
        RdnsmA2W0McYCGkXf+wAfwaFh4yc1ogFeDBmcia0hQ==
X-Google-Smtp-Source: AGHT+IFfa79r8JzdQtFx04Q0jSwJe+vq28O9bpW9OFC3zu3+PTnIGjWO8f+PDCS9NTgGvNiqIhAC7w7EsVeTZsDdYBE=
X-Received: by 2002:a05:6402:1518:b0:544:f741:62f4 with SMTP id
 f24-20020a056402151800b00544f74162f4mr210881edw.0.1699553001661; Thu, 09 Nov
 2023 10:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20231108064641.65209-1-haifeng.xu@shopee.com> <20231109095502.5a03bfd5@hermes.local>
In-Reply-To: <20231109095502.5a03bfd5@hermes.local>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 9 Nov 2023 19:03:07 +0100
Message-ID: <CANn89iJqVtN9icrqO-L0fiFNcVRYp7gdu6o8E5q=EUhHHE9WdA@mail.gmail.com>
Subject: Re: [PATCH] boning: use a read-write lock in bonding_show_bonds()
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Haifeng Xu <haifeng.xu@shopee.com>, j.vosburgh@gmail.com,
        andy@greyhouse.net, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 6:55=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:

> Reader-writer locks are slower than spin locks and should be discouraged.
> Would it be possible to use RCU here instead?

I doubt there is a case for repeatedly reading this file ?

This 'lock' is only for slow paths, it doesn't really matter what it is.
