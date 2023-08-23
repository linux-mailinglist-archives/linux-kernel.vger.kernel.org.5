Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07D1785972
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbjHWNgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjHWNgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541ABE7D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692797746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e81i7+rqpkC/zX4ymrp3HPYgAeBHOldKterDX4M7y/A=;
        b=FM+GWu/ADex/dZf1GEgNrD5ZjQL13rMvJ0PBufzCnDgd39xfR33B5h/C1o/Szf4/EA/ljT
        e0UH+6aSd3UkBmaR7CVyYX85ZciaTX+pP8/NA8ZMao/d1Yh/PwVUbLbMGeFpEjWxgIPQjO
        9p8edhwqvaknIS9kUEocYnMr9ZUSi6o=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-Fsyjtkk2N9K8uleFbpQcag-1; Wed, 23 Aug 2023 09:35:45 -0400
X-MC-Unique: Fsyjtkk2N9K8uleFbpQcag-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fe1f278abcso677843e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797743; x=1693402543;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e81i7+rqpkC/zX4ymrp3HPYgAeBHOldKterDX4M7y/A=;
        b=XUD7uam56wiJZx7dcGsnOfDRt/YSsqwNenH+hPflazkiJ/oATBX2F0Jc7mC9qLg1Kr
         Ff2A68powhhDEh7MD0Yy8yLmE4i10iiWYmoFr0Lap/COm2VGvOImB0bEe6GDWHUcPR92
         bYS3y67hGXGm0mwfBBfwejSP2PgW7dxlBkNNRvc6n0/o2HIKF5GFkRIeMiPE8H5ZCiFG
         SO7hvfLlItVsB3X6IxmeOLWt0r7znzTDk0nA3PQNUUJjrPYwA5qPBm6/aYmrRI7uIfVX
         pxobqIqMXvtwtAcuCnn9eye223eEXLaJQXm5AbnYu7zvM9Lb9cQRUHoPRnXgIoZvYnou
         TC5Q==
X-Gm-Message-State: AOJu0YwHgNxnX9o1DXVQEyC5/odO6sPIQMwoCRH1rayxBJmwTuHTdoZF
        k84epBep49fi/VVsoZ3801j5qSlnuBRrEkGbLIm6EkovhWmdmEEzL/xnyOSuOgXoY+Jpk0PByDc
        UF00ubVezkZcCeCSHtHfrnXMf
X-Received: by 2002:a19:7601:0:b0:500:8b4d:4cb5 with SMTP id c1-20020a197601000000b005008b4d4cb5mr3980811lff.3.1692797743678;
        Wed, 23 Aug 2023 06:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuhAiNrehaQQO98CGyKE6j/MfqLyPXBjiPxs+5vglJdyw+4A/bbnYK6/ewAxZMijt61Ww0AQ==
X-Received: by 2002:a19:7601:0:b0:500:8b4d:4cb5 with SMTP id c1-20020a197601000000b005008b4d4cb5mr3980794lff.3.1692797743358;
        Wed, 23 Aug 2023 06:35:43 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id mh9-20020a170906eb8900b009934855d8f1sm9789905ejb.34.2023.08.23.06.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:35:42 -0700 (PDT)
Message-ID: <0a842574fd0acc113ef925c48d2ad9e67aa0e101.camel@redhat.com>
Subject: Re: [RFC PATCH net-next 1/2] net: Use SMP threads for backlog NAPI.
From:   Paolo Abeni <pabeni@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>
Date:   Wed, 23 Aug 2023 15:35:41 +0200
In-Reply-To: <20230814093528.117342-2-bigeasy@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
         <20230814093528.117342-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-08-14 at 11:35 +0200, Sebastian Andrzej Siewior wrote:
> @@ -4781,7 +4733,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, =
int cpu,
>  		 * We can use non atomic operation since we own the queue lock
>  		 */
>  		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
> -			napi_schedule_rps(sd);
> +			__napi_schedule_irqoff(&sd->backlog);
>  		goto enqueue;
>  	}
>  	reason =3D SKB_DROP_REASON_CPU_BACKLOG;

I *think* that the above could be quite dangerous when cpu =3D=3D
smp_processor_id() - that is, with plain veth usage.

Currently, each packet runs into the rx path just after
enqueue_to_backlog()/tx completes.

With this patch there will be a burst effect, where the backlog thread
will run after a few (several) packets will be enqueued, when the
process scheduler will decide - note that the current CPU is already
hosting a running process, the tx thread.

The above can cause packet drops (due to limited buffering) or very
high latency (due to long burst), even in non overload situation, quite
hard to debug.

I think the above needs to be an opt-in, but I guess that even RT
deployments doing some packet forwarding will not be happy with this
on.

Cheers,

Paolo

