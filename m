Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF03778F1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242431AbjHaRbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHaRbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:31:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6B2E66
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693503049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zk4ElXSbDyoeIWWxswUZjXtDcjddTI//a78p4yp2fJM=;
        b=hnKyjGm1Lhc2vvtFGRikhrqElpu2NA4zUN5OBiTG9Mbv4hq3tTaWSE8N6Juss0mlmgUh5o
        weGr0LuWu34R4qVTHUlk0OChAdcSJxfzzalJtODjG1ph/GY3T84XpGOmy/CeW2g6jckmnf
        KVwid6ycT4gufOblcHB2MJDTzro8Qfo=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-t7DLaUYOOnux6vGl1nFUlg-1; Thu, 31 Aug 2023 13:30:48 -0400
X-MC-Unique: t7DLaUYOOnux6vGl1nFUlg-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-44d37cf5e28so518010137.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693503047; x=1694107847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zk4ElXSbDyoeIWWxswUZjXtDcjddTI//a78p4yp2fJM=;
        b=Cg/gYbiGK4pzpp3ZRgNSdKwYXohulmPba9LzknlhhCXFxPYjhHY+Wn0KEHb7eamKuD
         +XoQpxiX2pRJ5G/Xv8yS98EUqb24eLK3CF+apXm3lV5lG+IkmzSeRRbg/sOqXyWEGPTU
         IIUgg6CNoKBQfFpxjH8tcnf7Rzl3jzFtX7c0wBNWHJCrWRPj382cNPSWEie4E/mckjwI
         sZFCyBFccq6JC6LH5AvxmwDktNSuoFcz7qBuyFtg/xyARpufPkbZwrn9vo3mziv4gtMv
         Byp4jUJKA9ow2nhp1yiTOMNeRkTNNRgwKgX3ZpWLYKt0CUR+VzThLlmzkRHZBwXrgX4h
         obWg==
X-Gm-Message-State: AOJu0YwRrGxsuL5nhqCmc7E2QQdHdkN+yiyFue82oF1IE557QKCu6Jpj
        HkLvFR0OXN2YihDh/pZA5Ba9OZkQtU2fgpCr9q9MEmoPFleMCQ8jNp4aMC6ZpGNa7f7juW6QxPw
        HASokp4EJxqsLe+fVtve6IBtmiFknrWcBYs7g8Ma0ObA8sum5
X-Received: by 2002:a05:6102:11fa:b0:44e:9e04:bfdf with SMTP id e26-20020a05610211fa00b0044e9e04bfdfmr283202vsg.10.1693503046957;
        Thu, 31 Aug 2023 10:30:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPiDorpO7ycfqnlThKi8Nc4VYAE45f+3YSq3G0ZrlZJgGFcXnGWS0cXwVEoTR3s2Ddmi2XoWneMsZpqZ+aNi4=
X-Received: by 2002:a05:6102:11fa:b0:44e:9e04:bfdf with SMTP id
 e26-20020a05610211fa00b0044e9e04bfdfmr283182vsg.10.1693503046720; Thu, 31 Aug
 2023 10:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230830000633.3158416-1-seanjc@google.com>
In-Reply-To: <20230830000633.3158416-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 31 Aug 2023 19:30:35 +0200
Message-ID: <CABgObfYxjEiHARA2yCep7ck5snVYC1Ckh9prp3Y8J9xyRea8cw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86 pull requests for 6.6
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 2:06=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Adding a cover letter of sorts this time around to try and make your life=
 a bit
> easier.

Appreciated, but not particularly necessary. :)

If anything, I would prefer to have pull requests during the
development period if any larger features become ready, so that
conflicts become apparent earlier. Not a huge deal, we can sort out
the specifics when we meet at Plumbers.

Paolo

>   [GIT PULL] KVM: Non-x86 changes for 6.6
>   [GIT PULL] KVM: x86: Misc changes for 6.6
>   [GIT PULL] KVM: x86: MMU changes for 6.6
>   [GIT PULL] KVM: x86: PMU changes for 6.6
>   [GIT PULL] KVM: x86: Selftests changes for 6.6
>   [GIT PULL] KVM: x86: SVM changes for 6.6
>   [GIT PULL] KVM: x86: VMX changes for 6.6
>
> There is a trivial conflict between "Non-x86" and "MMU", and a less trivi=
al one
> between "Misc" and "SVM".  FWIW, I recommend pulling "Misc" after "SVM", =
I found
> the conflict that's generated by merging "Misc" before "SVM" to be terrib=
ly
> confusing.  Details in the "Non-x86" and "Misc" requests respectively.

