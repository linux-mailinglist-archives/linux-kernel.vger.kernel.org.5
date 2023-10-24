Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F037D539E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbjJXOFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjJXOFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BC6199F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698155784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iQvE8OdPfOZYSkHw0w045+f5o9rL3SeUMTEWpiF8tRY=;
        b=D4eMGwaFGH+mTZ2d95yL5c0yQ0vSD+UhAC+WMeyaW4pjxVtMjMVkCrE++D/zahOQJaPIoQ
        4zgjIdK4rbPd0CD0dhJr7s8aLZX3P6FtRkrOLSoiK5rlLm31Z8msDzu05SCbbY5UMgjuiA
        1vo94pqUmGyRnPw5fbQxGHq+IY+74T4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-Z7nqNAE7Nz-yyRtWF7nvyQ-1; Tue, 24 Oct 2023 09:56:21 -0400
X-MC-Unique: Z7nqNAE7Nz-yyRtWF7nvyQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-41e1ecf3350so5723321cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155780; x=1698760580;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQvE8OdPfOZYSkHw0w045+f5o9rL3SeUMTEWpiF8tRY=;
        b=gTI8ADcdzDsJ7m/fPO1DU6uI4hu9bt/a9TUTkgoe+lN6z6CmxYZ4sqE9UI/b7jlc4K
         wOmHeNhDnUxiVc9f3zQXoTkRgsDVQSYA+Hh4t3yx2rwJjO8ZkSvWkLwWWGrMkksBFkeS
         bAPNjFcYtd7m9ih13rDblfhsWksE176Z2EXYsEb22+2zU33ENdRoXM/L10pd98+hwe6B
         kX4UlPuDlI8Cp7H5p4OYg/m2SDPLEFAKsQBGbBcg6j1Ady9GvzrbobSxArcoOIep/3i6
         i21v3WtYKOGA9J7wTviagStljMe/yBvRCTKUKtHLtfxei8JpP3IEfqlLR2JhJXjsp2RA
         s1Ow==
X-Gm-Message-State: AOJu0YxzCIKVDzNcAuARSJ98MGFEDu5H59NmJBGZ5AHZhuJ95NWn2PgG
        DBexQXl6o9kQW7pnxms7a9ySUJTtUN7t5U+qnWlpeLr6zZnLk4oU73YFRgG3W/wGw+78i+rFhTh
        kb0Xk0zQnOnPhXlkMXx8+9tmL
X-Received: by 2002:a05:622a:15c2:b0:41c:d444:d08a with SMTP id d2-20020a05622a15c200b0041cd444d08amr14354094qty.5.1698155780640;
        Tue, 24 Oct 2023 06:56:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp3HkQo1SE5CjzQCJM1P53fM6YXXkusZPqIbLJPLZVwjCEjtEC1Ta45eBdaH/W2xlMVb/FOw==
X-Received: by 2002:a05:622a:15c2:b0:41c:d444:d08a with SMTP id d2-20020a05622a15c200b0041cd444d08amr14354077qty.5.1698155780340;
        Tue, 24 Oct 2023 06:56:20 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-180.dyn.eolo.it. [146.241.242.180])
        by smtp.gmail.com with ESMTPSA id bn14-20020a05622a1dce00b0041aff9339a2sm3450689qtb.22.2023.10.24.06.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 06:56:19 -0700 (PDT)
Message-ID: <addf492843338e853f7fda683ce35050f26c9da0.camel@redhat.com>
Subject: Re: [PATCH] net: Do not break out of sk_stream_wait_memory() with
 TIF_NOTIFY_SIGNAL
From:   Paolo Abeni <pabeni@redhat.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        kernel@pengutronix.de
Date:   Tue, 24 Oct 2023 15:56:17 +0200
In-Reply-To: <20231023121346.4098160-1-s.hauer@pengutronix.de>
References: <20231023121346.4098160-1-s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-23 at 14:13 +0200, Sascha Hauer wrote:
> It can happen that a socket sends the remaining data at close() time.
> With io_uring and KTLS it can happen that sk_stream_wait_memory() bails
> out with -512 (-ERESTARTSYS) because TIF_NOTIFY_SIGNAL is set for the
> current task. This flag has been set in io_req_normal_work_add() by
> calling task_work_add().
>=20
> It seems signal_pending() is too broad, so this patch replaces it with
> task_sigpending(), thus ignoring the TIF_NOTIFY_SIGNAL flag.

This looks dangerous, at best. Other possible legit users setting
TIF_NOTIFY_SIGNAL will be broken.

Can't you instead clear TIF_NOTIFY_SIGNAL in io_run_task_work() ?


Thanks!

Paolo

