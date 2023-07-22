Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9AB75DAF4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 10:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjGVIFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 04:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjGVIFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915A82D46
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690013083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jbSZkv9qcwLx6TkEBQeR4Wnol8rh9QTnB0QIfSJxe8A=;
        b=I/TVtsFCJ2V9d0sADVBXuVTqNHPjMAecG2iL7WcQXn+tkJPDfuUc1/IRd+TyxOkf56a2k5
        zHAVJRnCF+wINbVJoqVRxEc3GqrXbm94oiT+A022G6L1jVLUV9RXm79lk3kxZg5gaUTpHv
        zAlcAqxYF5tod/fuRJrGJj8myuyVkcg=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-DLEIkQQMMruDLuF9jb95dQ-1; Sat, 22 Jul 2023 04:04:41 -0400
X-MC-Unique: DLEIkQQMMruDLuF9jb95dQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1b457db8244so4771928fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690013081; x=1690617881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbSZkv9qcwLx6TkEBQeR4Wnol8rh9QTnB0QIfSJxe8A=;
        b=K4TcyVPjuVtzPGkJxYphZl7m9gtSqfmkwf2xzYJ2dFMn5ObK5fdqn3enkvw0YciQiz
         7I/a16F6Fspe0vx1xa0rFv6BRlWEXIPw+OmAoZedpNvVm+uPQvrSCcYye+wogCoPPKOJ
         sv8bxjLeqZtqF6743XyJuxc39R96Bo4JH564tpiO0dTbZTlMNUVDvm3FfTMxu12P5Qiu
         8YrPRSbJUZjsxNwCzIiBd36KKgh2nLufDk3xt6v8AMI1CGXn6RRcAJrC4pOSCXZjDvlf
         JFYt3t5Y6KZ1faYjA6Kta/D2ktTFq/H9L7ZvoYTBnN9+sDlgOODn7sGtz2KMOwdJAmB/
         s08g==
X-Gm-Message-State: ABy/qLbt9ZPFP4eXKgwDolRdkrlFA8grSUtq2/iN0WpiAiXep9MuErbf
        t3/5mjsMje4iOyonNJfJQ2yGStBnCIQpoEUpOcUgL/LE+lQSn4bwwf8Wo6Us6WLmVFm2suifX4B
        jmq8h9S20C/Z753zsRJdLa5Ls0QyYJa9Wrbd+Y/Cz
X-Received: by 2002:a05:6870:f69e:b0:1b0:43b6:e13b with SMTP id el30-20020a056870f69e00b001b043b6e13bmr5415911oab.54.1690013080956;
        Sat, 22 Jul 2023 01:04:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHTHBxJ83OPWYjyyNOUC3XHdVgTNzaset85zkOMNxYBC17Xoo0VXVQRCj/sg/zGs6W4odjxmgoFJn4fb7835PI=
X-Received: by 2002:a05:6870:f69e:b0:1b0:43b6:e13b with SMTP id
 el30-20020a056870f69e00b001b043b6e13bmr5415901oab.54.1690013080765; Sat, 22
 Jul 2023 01:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230716193000.231406-1-costa.shul@redhat.com> <9b212c49-ab51-0cd9-5871-c145c5f41b48@kernel.org>
In-Reply-To: <9b212c49-ab51-0cd9-5871-c145c5f41b48@kernel.org>
From:   Costa Shulyupin <costa.shul@redhat.com>
Date:   Sat, 22 Jul 2023 11:04:29 +0300
Message-ID: <CADDUTFx+tfdkLp=wp-XH-U1iB3ZM90W=ktbR4ckp62pDmUGPMg@mail.gmail.com>
Subject: Re: [PATCH] tracing/timerlat: Add latency threshold
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:TRACING" <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> rtla timerlat has the --aa-only that ignores the trace until
> the tracing stops, and then do the auto-analysis based on the
> tail of the trace.

> So, as I said, I am not convinced that adding this interface file is
> better than setting the stop-tracing option... and then waiting for
> the trace to stop... parsing only the tail of the buffer.

I see. Stop-tracing option of rtla timerlat solves the problem for
most of the cases.

Thank you very much!
Costa

