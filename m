Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6ED77885E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjHKHjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjHKHj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:39:29 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A6CE73
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:39:29 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40a47e8e38dso125561cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739568; x=1692344368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mGj/IvUxGsWCDiYlrlJ8w5YX+AESHKKi7ix/f+88H8=;
        b=QpKmBm9X10I1cpwca31UgiVWToGYbGkx/PnuwE5LYZ+ZGiu7acRaeRgkjRl5/6Bcs9
         DSyvJMQ3Wj06s0HofvgOKcku+03sC55CqTxSFfTptpfWDJQzoWUyHZ9ds8KSWNR4+93U
         JzDmWk2Tenttj5CFeiglCAd36kqD1RCUNBnxELu2MSeq/1n3xlKQjmAKMk659OkX0bcr
         e7SI89UbclSBqJ9qD/uK8dcduxIjyHpl9PZi1JKqX8MB0B9peMGdL2ESlP3IE/xhqPl+
         savezKpXgvmXNH42EWoN7Ef0tuWQekuPjjZrPv1SRQEapYDv+frIdlSAMAs6FrK8a2cd
         b8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739568; x=1692344368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mGj/IvUxGsWCDiYlrlJ8w5YX+AESHKKi7ix/f+88H8=;
        b=ig0XwEQreBHnPmVafSj6XxsXbh7ZGNobuyZp9zk0pV0OMipAIQnkpGWR6yBTtbFSnR
         xYu94OOq6VM+MCnij6LZA5pJWyhCRqCayc5/d7sg8KOCUfhtMQbBmXbCQoT1UuQunA2j
         4qf8ULH6ES0td/pf6fEbW9SqvZTrePVsfSS9fn0yeAdBkPPQksM3TcIFtjeuu3KQLY0I
         YWI/6n6pKjSWIhfzFlF0U8vgrkmcIYDil613l7DDD3I4X6ASS+e2Qeto/KXxMpHoGRg8
         x897taYSQIgoaDVb03IqoPs+ePYF8WErfgi9DhsAMrOBzzV+d+2QNFSyhQCS0f7inu4S
         yAiA==
X-Gm-Message-State: AOJu0YxVnfKWyVkInHBHy5vxWs2hRY/gfu7gfFfhOujf8XU4X9oF3l4g
        vJ0EWR9pkSP5qItVOUvdIITKxA05XMTVYH9ChzmzbdNvxjEQUDGiYpoE2A==
X-Google-Smtp-Source: AGHT+IGEo8hTHIWhEthJEXMpXEEsoBCNaV27+0xDNHg7511j4iphouiDh8GHMv7wfDzaHVWNQL2F4sklwgNRGDCjoZA=
X-Received: by 2002:a05:622a:1b8c:b0:403:affb:3c03 with SMTP id
 bp12-20020a05622a1b8c00b00403affb3c03mr183373qtb.10.1691739568069; Fri, 11
 Aug 2023 00:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230811025530.3510703-1-imagedong@tencent.com>
In-Reply-To: <20230811025530.3510703-1-imagedong@tencent.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 11 Aug 2023 09:39:15 +0200
Message-ID: <CANn89iKYKSBsaYiXKoJs-iHK5+zx74hKiDwMxV0_58kNEB3QBw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] net: tcp: support probing OOM
To:     menglong8.dong@gmail.com
Cc:     ncardwell@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
        Menglong Dong <imagedong@tencent.com>
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

On Fri, Aug 11, 2023 at 5:01=E2=80=AFAM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> In this series, we make some small changes to make the tcp retransmission
> become zero-window probes if the receiver drops the skb because of memory
> pressure.
>
> In the 1st patch, we reply a zero-window ACK if the skb is dropped
> because out of memory, instead of dropping the skb silently.
>
> In the 2nd patch, we allow a zero-window ACK to update the window.
>
> In the 3rd patch, fix unexcepted socket die when snd_wnd is 0 in
> tcp_retransmit_timer().
>
> In the 4th patch, we refactor the debug message in tcp_retransmit_timer()
> to make it more correct.
>
> After these changes, the tcp can probe the OOM of the receiver forever.
>
> Changes since v3:
> - make the timeout "2 * TCP_RTO_MAX" in the 3rd patch
> - tp->retrans_stamp is not based on jiffies and can't be compared with
>   icsk->icsk_timeout in the 3rd patch. Fix it.
> - introduce the 4th patch
>
> Changes since v2:
> - refactor the code to avoid code duplication in the 1st patch
> - use after() instead of max() in tcp_rtx_probe0_timed_out()
>
> Changes since v1:
> - send 0 rwin ACK for the receive queue empty case when necessary in the
>   1st patch
> - send the ACK immediately by using the ICSK_ACK_NOW flag in the 1st
>   patch
> - consider the case of the connection restart from idle, as Neal comment,
>   in the 3rd patch

SGTM, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>
