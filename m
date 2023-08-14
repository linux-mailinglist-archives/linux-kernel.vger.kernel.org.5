Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5B077B996
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjHNNSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjHNNSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:18:06 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF1F12D;
        Mon, 14 Aug 2023 06:18:05 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1c504386374so535100fac.3;
        Mon, 14 Aug 2023 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692019084; x=1692623884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tciLO5aIFeWALn4B+WuHKgBZ+0zyAoOpqtrps2MSa0I=;
        b=RLmAQ1GQK22rhXIpBwgMSRQe6kAaOWCeqYSmoO7XVu7W+jIjZAivlY7p2Ibdd+kvm0
         R4PVaSaslxBI17MTqjXXL9pOFDZnuvFI5GtrrGLlGty5g2VPlcTizFGQXE2q7fxv9FE2
         VTaLTUENc5nlW46TX60tueNgC9Ab22TMCfJFOWBKUb/wor10f7QH0ThXWQXZQTE6I4tO
         2f7vtaj3XPMYqp1SR1Q6VemydFH0AjkR60J1yaziRwS6IQc6U1P/o7GV7HZcgzJ3D1Yr
         EFR25XhQ7uLhN8Ug/U0sk0lpKdRinoobn5AyQkbY0YRW6HLLwpphCKGzwtgxdB8PdWJD
         YzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019084; x=1692623884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tciLO5aIFeWALn4B+WuHKgBZ+0zyAoOpqtrps2MSa0I=;
        b=LQFhbmrMDTKmWsoPdTKq4NJMpZBmuzv8DtOdyBBWDvkCb6UbnAjw73kdyPys9pKvgd
         SLPwYxA8VLA05OguwJd28vtCDjgRaiypWM5Oiqn4zuvSwAH/TFEv7Ao3nK8ymQFlBgVA
         ht20EqWHZZbNt6BPR7iHkBt/CiXJktAor5nUnjZZOjq7oclWusLY5Wf0Db720Cg91a68
         F3oKIZrLLrDkglcTWnr5VCuIXMPYo7X6zSVkLh9SFag3Qotg/CyRJkIdlAL0mSfXnZxW
         y2GkeCmipkddBhBumCLZaPgHXQEp5eF9iD9m/QTzmOlXffVXjKIcjNdKFQtT/6kGLN7N
         cowQ==
X-Gm-Message-State: AOJu0YxpFKJCJG1rvCvKgGU2XVAgS0htJxbIBRzRAvuUPvzZEuLkjUAm
        mYN+kQtJTd0aG48X/YAWCOzUNF+gcBTmXZ8UvCG2KgPFNzQ=
X-Google-Smtp-Source: AGHT+IFXW5h7oxdY3BTPwoujmhAS/pefvYYF4kWoJeZSYIfCNmlR1SSqhyHhQJfYXWSaXyN8FgqMVQBk1BSuPNJc+g0=
X-Received: by 2002:a05:6870:9629:b0:1b4:685d:55e4 with SMTP id
 d41-20020a056870962900b001b4685d55e4mr9266601oaq.39.1692019084446; Mon, 14
 Aug 2023 06:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230813160605.1080385-1-sashal@kernel.org> <20230813160605.1080385-28-sashal@kernel.org>
In-Reply-To: <20230813160605.1080385-28-sashal@kernel.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 14 Aug 2023 15:17:52 +0200
Message-ID: <CAOi1vP-TjjckKBNAiiTQDpgxVVKU0NFW0OrxADs6dz4p6p0yfQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.15 28/31] rbd: make get_lock_owner_info() return
 a single locker or NULL
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dongsheng Yang <dongsheng.yang@easystack.cn>, axboe@kernel.dk,
        ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 6:09=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Ilya Dryomov <idryomov@gmail.com>
>
> [ Upstream commit f38cb9d9c2045dad16eead4a2e1aedfddd94603b ]
>
> Make the "num_lockers can be only 0 or 1" assumption explicit and
> simplify the API by getting rid of output parameters in preparation
> for calling get_lock_owner_info() twice before blocklisting.
>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Hi Sasha,

I think this patch, as well as "rbd: harden get_lock_owner_info()
a bit", have already been applied to 5.15, 6.1 and 6.4 by Greg.  The
emails went out on Aug 1.

Thanks,

                Ilya
