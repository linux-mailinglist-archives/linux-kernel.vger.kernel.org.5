Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AAD7A9EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjIUUFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjIUUFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:05:32 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094E74006B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:58:40 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-414ba610766so90891cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695326319; x=1695931119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FfisnjYNsOL8cGxpX9K2HnFfkT4nFMBwQIPYmNAGaM=;
        b=DohyFrj5ueb5UIv15uZCeZD62asacUfPm4Fwbouisr2CHv2+V4pzfby22+TCYL9O4o
         LpmEc+ap+fcvDVBqB73CX9ahfdy8fCqJXIOsioTGGUZB666VpC2w5X5qsm94GC0GMHqw
         9KLX0aVF1DsLDmfjTJ8wsf8gh+AlhAVCUYLpI1G+9tVJm/lQjwzaX1J88UpXdri/3wkf
         gyfbiOcbUVwdJ+0WLRTA2UXeXuvHSLi56pv6/v36Qjj+JwPvCxiBfa11aVfqWgQN0GZB
         LpgHPmSzYAp6zdjFNHqlkZgLS/Vxw916p5s3yKbyRBrCHwSiovUvUb3BvE/eCXtUOhpG
         gv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695326319; x=1695931119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FfisnjYNsOL8cGxpX9K2HnFfkT4nFMBwQIPYmNAGaM=;
        b=BxlsM/eMGRF5HGQVfrJ/+oovmhLi+vNTE5g8w1wmxU4AznaSQoeqeDcZSKEfKLxxFt
         Y/ziXsHb+VhszJcVc6FMHdiFK31fsATN7Os9ECMpybCsAKzKlFCMWGCTVFxzgt73cCNe
         +kkcpwRZ8++sF5hiS6C48wLbklaceqHgv/0UQkXdLrOjOUWJDYRmo3MeYo6T3QPK5pZN
         X13yNh1LT/spzpo2hSO7yWPY2Mw/zatcMe/3Ro+OhipYacg8cJwWwZ+E+uIitdAI8llf
         rVKRslQDbiUBXzgyzXpB6Qlp69ptIfWg59xoKsHqP4jzR99jGtdcQcA2XXAVnc6a80Ov
         JFFw==
X-Gm-Message-State: AOJu0Yy2mSlytrZdb8aG5943dYjogM5zDXWbJ5RAihiMcd0tO67BzEZh
        ucIuo4Hrw8n+w5Hxp6N8jnW313QePYcwBmxIFXgNQg==
X-Google-Smtp-Source: AGHT+IGJ6jwXUXExcyx4muo67lAz2nyvdpM5sjjvIUw3AuPhH7KtatRQfNyEvOVD8w/QtrqegvvcUU5CU/+Dkj3DoD4=
X-Received: by 2002:a05:622a:4d1:b0:3de:1aaa:42f5 with SMTP id
 q17-20020a05622a04d100b003de1aaa42f5mr1926qtx.15.1695326318747; Thu, 21 Sep
 2023 12:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230921194314.1976605-1-i.maximets@ovn.org>
In-Reply-To: <20230921194314.1976605-1-i.maximets@ovn.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 21 Sep 2023 21:58:27 +0200
Message-ID: <CANn89iJxrsgeS_FOivxPdYLhPyLC6Lo8VBzLjdx9-mQKXxqjwA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] openvswitch: reduce stack usage in do_execute_actions
To:     Ilya Maximets <i.maximets@ovn.org>
Cc:     netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>,
        Eelco Chaudron <echaudro@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 9:42=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org> =
wrote:
>
> do_execute_actions() function can be called recursively multiple
> times while executing actions that require pipeline forking or
> recirculations.  It may also be re-entered multiple times if the packet
> leaves openvswitch module and re-enters it through a different port.
>
> Currently, there is a 256-byte array allocated on stack in this
> function that is supposed to hold NSH header.  Compilers tend to
> pre-allocate that space right at the beginning of the function:
>
>      a88:       48 81 ec b0 01 00 00    sub    $0x1b0,%rsp
>
> NSH is not a very common protocol, but the space is allocated on every
> recursive call or re-entry multiplying the wasted stack space.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
