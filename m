Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542A57A7491
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjITHpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjITHoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CF0CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695195830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cQY/xb2Ut4I8guUVtcmZYuOrVGNbPd5OCYHLcWkr4PQ=;
        b=TO6IdKsmDcLxYyCB2JDPtnsEnSWG2OR1G4y/eL3blNPKGs9sDjQsGHO/Q2uJ7Ih21aK9Za
        3HqbLbcS3BLIzeDNFSmqeXinkTsaX2cBAXFdBfFYLPlqkYE+0TloGdFcsuLsQIIw8XhJEp
        z9CexWmrvCA266fJbflq3Fvawn89EKE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-ydy1K_gjPmORB-WrSFGEEQ-1; Wed, 20 Sep 2023 03:43:48 -0400
X-MC-Unique: ydy1K_gjPmORB-WrSFGEEQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-792701056b1so156397839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695195828; x=1695800628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQY/xb2Ut4I8guUVtcmZYuOrVGNbPd5OCYHLcWkr4PQ=;
        b=rhoP2jtqG+VjfkBH4VA9OITYsl1Ld+BWLhT9J6rgaapydud1F2+85D+TwOmGDfw617
         9yw5zjswdVDTqmdt6AY3A91Ft4scJb3AsYsTstK4vWSj3HyjV2UNK7G7/BiQBqMnUZjK
         gBLG2CNxUI7KnKc7/mfXYK71WxF6Z0ToSvh1xi1jji3istGppSZCyfbjbaLnhz4Sfd2/
         GlAQkL1y3fobyXKzby0zTxtD0QXjq15HJ51t0ZaPTz2YMC1XOiJzGn7BUyfxMQgjDmbT
         25DE1AjlQy6OMdRYxGlhntaYbkUjeC5pXtWNh0hpL3cFSqEwphl+iyg1Kcudt9fXcPRi
         lB4w==
X-Gm-Message-State: AOJu0YyeCYqcgpnX+iI6Dte0Q3uxNGWB38Yk3izadBlvt5CxrTlWEaYF
        J4zLQQfL/cqQ+b0O5XiIgRtcJ9cE89LVVY/sqxnxOcIX79QTqDcVRjTUOrvSDQuRXGN4jgFNsB6
        2MmoCpYuHYmlnnJyM3bqbSBhevLe/H3iwZYrwgu32
X-Received: by 2002:a92:c649:0:b0:34f:6e08:d6a3 with SMTP id 9-20020a92c649000000b0034f6e08d6a3mr2061576ill.0.1695195828112;
        Wed, 20 Sep 2023 00:43:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhKrIUaDVR8FWBSE8eiA+LxkP+Hvqf+lgVMJ5a3lTeGzEqd1tzKJSp2LFhKHoV6H2rV3NESf0IQB4QSqC7HKI=
X-Received: by 2002:a92:c649:0:b0:34f:6e08:d6a3 with SMTP id
 9-20020a92c649000000b0034f6e08d6a3mr2061565ill.0.1695195827853; Wed, 20 Sep
 2023 00:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230911052535.335770-1-kernel@jfarr.cc> <20230913160045.40d377f9@rotkaeppchen>
 <63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com>
In-Reply-To: <63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com>
From:   Dave Young <dyoung@redhat.com>
Date:   Wed, 20 Sep 2023 15:43:27 +0800
Message-ID: <CALu+AoTAUWWtx8yChQMKF9J5X_Qd8+x0hz0jzVwoOvAvh5VmHA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
To:     Jan Hendrik Farr <kernel@jfarr.cc>
Cc:     Philipp Rudo <prudo@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>,
        bhelgaas@google.com, Luca Boccassi <bluca@debian.org>,
        lennart@poettering.net, "Liu, Pingfan" <piliu@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > In the end the only benefit this series brings is to extend the
> > signature checking on the whole UKI except of just the kernel image.
> > Everything else can also be done in user space. Compared to the
> > problems described above this is a very small gain for me.
>
> Correct. That is the benefit of pulling the UKI apart in the
> kernel. However having to sign the kernel inside the UKI defeats
> the whole point.


Pingfan added the zboot load support in kexec-tools, I know that he is
trying to sign the zboot image and the inside kernel twice. So
probably there are some common areas which can be discussed.
Added Ard and Pingfan in cc.
http://lists.infradead.org/pipermail/kexec/2023-August/027674.html


Thanks
Dave

