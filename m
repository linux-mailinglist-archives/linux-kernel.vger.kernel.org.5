Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF87E762AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjGZF4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjGZF4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:56:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3019C170D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690350952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BoO6p8OipFbIVRp/vUM7Zcf5r2fw8A+sOpUnPYaEJPY=;
        b=QfBCgUisSAw1x28Fj7iy/1SoL0N7LX5/d3t2S2duFCVs28W/mE2C8AteaNP1OYh6aGnauz
        cFQ5Bt9XqXwRPjeJ38E4knRiWpLfWOnEb9VOwLD8Yy9EPpeDvnzy7K2jlj15aWCjd/DluI
        W84tZObKYQTrqdZ2MrP1PdAIvte4jd0=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-oorp5MzBM5aPLY0bVpSIZA-1; Wed, 26 Jul 2023 01:55:50 -0400
X-MC-Unique: oorp5MzBM5aPLY0bVpSIZA-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6bb0ba5fbcaso10565823a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690350950; x=1690955750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoO6p8OipFbIVRp/vUM7Zcf5r2fw8A+sOpUnPYaEJPY=;
        b=TaM/BdKfxWmSttMLbhjWLvsLOHeeAqG3ZFV61YSPisBQt77jx5OBlqn5gb9o6j6jJM
         SP7iB2ONoNrfVOKsbamlzxaa82QcZL1eS7gI8SpnfLb1iUblTEKyWuDFxA/TkymKG5EL
         IJiQJsuXf3xx/w32TGPB7Zp6B9aTeMf12TkLHT7AXLq6Nfvwtr5OsCnENtn/77eCDV5A
         4/Sa0g8N9XGPgHdC/IhTNQgTNOz65AP0+63SXlNArnx1LwlIRNJ1dBiReQauppmIFBDG
         WfzcC2o7l/hVYXRPdxfGb3u4Z396y72z0Ldr7AqJ6WtO9rbBCvlGMeUOtu/l9xrwmZjI
         J/rg==
X-Gm-Message-State: ABy/qLaEnsXz4hLx9ZwGQWD2loGBSkHKEf5vfXd7v+RAo8+0j+MVG0Lt
        uweCXofYjdtHlPY42KAsTCPMQ5h6z2M7gKide6OyhxuPjHfg2krlj1pcoJrM5LlWE5BBgbeE0za
        SiDlVadFbFq1+k/PD8rh0mw9iuhRNLIFYBDz3QCbF
X-Received: by 2002:a05:6871:806:b0:1b0:2ded:bd7 with SMTP id q6-20020a056871080600b001b02ded0bd7mr1353704oap.26.1690350949959;
        Tue, 25 Jul 2023 22:55:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGMDM0FaPwcSQf/RqvNSpjmA0qJJtEYdpnUKfPyPzpzqjFUhCmFN8imrQA3L7qRhB+SgUcXRspcP18bjzS8d/o=
X-Received: by 2002:a05:6871:806:b0:1b0:2ded:bd7 with SMTP id
 q6-20020a056871080600b001b02ded0bd7mr1353696oap.26.1690350949784; Tue, 25 Jul
 2023 22:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230724193118.2204673-1-costa.shul@redhat.com> <87ila9atuk.fsf@meer.lwn.net>
In-Reply-To: <87ila9atuk.fsf@meer.lwn.net>
From:   Costa Shulyupin <costa.shul@redhat.com>
Date:   Wed, 26 Jul 2023 08:55:38 +0300
Message-ID: <CADDUTFzKCrrBT=46F-08_EGrwMxVniDOgdkVr-DhGFTzS3DxOg@mail.gmail.com>
Subject: Re: [RFC PATCH] rework top page and organize toc on the sidebar
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION PROCESS" <workflows@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch is somewhat difficult to apply, as a result of:
> > Content-Type: text/plain; charset=3Dtrue

This is caused by em dash in the context line:
The following manuals are written for *users* of the kernel =E2=80=94 those=
 who are

I haven't found how to fix it. Are there any tips?

