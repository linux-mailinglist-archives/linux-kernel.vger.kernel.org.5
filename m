Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E483477640D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjHIPhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbjHIPhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7A426BC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691595330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hFCXCcVRqjVNAx39yHPnzwfvF93h2H9oIYZzJlPTdH8=;
        b=RKxZNXF/u83qmvFWOuQc6v4yn8mZl1IJ9rmzCDZD7qGWAiY5RxdgVaHCuex8hvoxZL42hD
        V+cbtzFg5SmIzQBX/qDtFQmWVLvYnubxqSX5uhpbV2P4Sg6FaLhVFj8Dx8huHPIbsnPl9v
        1I4Ww9XZbEg8rPuO405eAz1MlCP6ONQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-wOui-ZsTPuGXFaxLQU_ytw-1; Wed, 09 Aug 2023 11:35:28 -0400
X-MC-Unique: wOui-ZsTPuGXFaxLQU_ytw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3176eb6babbso540575f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691595327; x=1692200127;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFCXCcVRqjVNAx39yHPnzwfvF93h2H9oIYZzJlPTdH8=;
        b=c4KBKqwifCZAQ5APpQEFFqTsFhdmHzMe7jtZh/mGk/jKztzHSE1au4BDMc/fP2g6u2
         gZZAJ7BpjkXTBg5PW3sXHoozcBQK8fHx6/fdXGwJIGbCWb50z2sDmG/AeVsPop434+j2
         qa/k4CSWgecObK09eOhVB3IrXp3nXigaeNdCjBlJV/13ucyfCeLIKdD4XJf8xWdoMVFd
         QBO9NEgiR+1rkDV18TQwSJccHcKlkQFvTC1I4HjoWgc5cBdHvpifGmZQdboNMKJxbjNf
         pW3oY0n4V42sswQSC5MxPsghic5r3g/nusbroaylf8YyjTzsjeoWdmaEmsi4wmM+vRPH
         4c6g==
X-Gm-Message-State: AOJu0YwoyDQuE20g9WfgSL3xszTxkUePBQ4gfSU4KszgDpfee6E4Fdig
        1trfOq72aUs3A0GPnZKSHfX6ghBMxqlzxkpmtUGCAgJaajqrS7VvgAwlRHzSSVyGm3XSs8/Qz3m
        8CnWVCl0/okx2L/SpOUiB6zUCyAgtcgiSu2G/IQpAFcFboszYo5lKStl/No0CsB46rkBQ90+yx7
        tOh/Q426BE
X-Received: by 2002:adf:f7d2:0:b0:317:5dcc:b7d4 with SMTP id a18-20020adff7d2000000b003175dccb7d4mr2700185wrq.33.1691595327317;
        Wed, 09 Aug 2023 08:35:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEukse6LgowT07XlF1KpkYoUz+HcoKmMpsgKHJ8E0IcN+wcgaWWWDndB5JE0v2ihdFvzBgC3A==
X-Received: by 2002:adf:f7d2:0:b0:317:5dcc:b7d4 with SMTP id a18-20020adff7d2000000b003175dccb7d4mr2700164wrq.33.1691595327021;
        Wed, 09 Aug 2023 08:35:27 -0700 (PDT)
Received: from vschneid.remote.csb ([93.186.150.163])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d4d42000000b00317ca89f6c5sm17017766wru.107.2023.08.09.08.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 08:35:26 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] sched: Use lock guards, wave 1
In-Reply-To: <20230801204121.929256934@infradead.org>
References: <20230801204121.929256934@infradead.org>
Date:   Wed, 09 Aug 2023 16:35:25 +0100
Message-ID: <xhsmh1qgccjpe.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/23 22:41, Peter Zijlstra wrote:
> If there are no objections / comments, I'm aiming to post the second batch at
> the end of the week.
>

Other than the nitpick on 5/9, the conversions LGTM.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

