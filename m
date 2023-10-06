Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAD17BB422
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjJFJXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjJFJXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:23:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B1B9E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:23:41 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-537f07dfe8eso7650a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 02:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696584220; x=1697189020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+2OvC4UsKZZVe9u7q5rQ09fkS7zT+qmc1odAaqtWMQ=;
        b=tsVryQ+Joxok1ibkzWKvC5RRpWqYT7/45ua+wQC8wrFCj4OGbsrq/sVmxJ7I3yUaAw
         ZxAaExfzWFpJ9iKDA5NSEJ0Zkk2lbJRtvKdj17FU8f2vSn5+aaBKPoOnnt/SYAj0HwUi
         3YtNkBp6hSFF3YnI9Sz91BEYwdeBdcSjlNtwg6yQWV0tswWIq6TR1MNXvZYQDX3BO8YZ
         Yw38HG5aUBnuecmN8SG+sRzguiJ6lGJsGm+WftBh8xvpODWECvR9BFR//DDasQyl/KUS
         GHo9zsJpIdUSLz6HODbTFPZIasLArDmuO6rYwM7Ho13unfvdw3Mrc5M3D60uUo23YoJt
         M0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696584220; x=1697189020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+2OvC4UsKZZVe9u7q5rQ09fkS7zT+qmc1odAaqtWMQ=;
        b=HMslkiIYFYJ9oLz/8jgVGeRLxfoTtZXldToCPksAlwM/dMeJahhsULLklKo3iKqwuD
         eF63+fi8+dnSI395dzQslYymD+Cstr8psuPHLoRYaeCloK95b8fWxYhE+KYIUwqfHMeS
         obgHhMdLs8eLLHaGwIxyMCixDA5ZCtrRV0cAoSXYe3gky8ZQLJGqe81UXJ8eNqPB6uGc
         kDa6RzFZ9sm72E3Bwnj/AQDPrIqZwAhaRLGiqyby8nwzaaU7fJ0bZcbDmp4gqlyC3dfs
         6tQbZ7bASigdHVxZohZwYNsDijydw2Obl2JfeyTeoT8zlSP6VwKIjHVx9ocy6dKRA239
         kaFg==
X-Gm-Message-State: AOJu0Yzw9ekQPtFzrnuljbz1E5pBQgztgoOLm7L5m/ZOuZuALMAr3Ptw
        PPc0NSJxzykz/lve25kmxYM2VgqpugYyLm7O+I4/nw==
X-Google-Smtp-Source: AGHT+IHoIPRhtUQ5uuIPkP4QsVp+QK7bs+DXcxmsIaDAcPgDTfHtOTqkQjKrkJrop+V5dLLPZT7C8FCSJqLUpERZH2o=
X-Received: by 2002:a50:9e8d:0:b0:52f:2f32:e76c with SMTP id
 a13-20020a509e8d000000b0052f2f32e76cmr184149edf.2.1696584217891; Fri, 06 Oct
 2023 02:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231005181747.3017588-1-florian.fainelli@broadcom.com>
In-Reply-To: <20231005181747.3017588-1-florian.fainelli@broadcom.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 6 Oct 2023 11:23:24 +0200
Message-ID: <CANn89iKF65tsKRXoAx6tPmgf-y6zBdT7OgNShNrVjdPjGNOEsA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: bcmgenet: Remove custom ndo_poll_controller()
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 8:19=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> The driver gained a .ndo_poll_controller() at a time where the TX
> cleaning process was always done from NAPI which makes this unnecessary.
> See commit ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")
> for more background.
>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Yes, many drivers should do the same...
