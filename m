Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5120758115
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjGRPhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjGRPhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F35A9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689694627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WFSYW0DOGpPster+jaAtGmVXakx425pOilKzR4Mqu7g=;
        b=h6Jq5w8ThTZuOFE2qURFnyiBsdIm4VQtAeFYIEjod04SpJRxTPUys+HqnEoABVk+Xo0dI+
        IMj0nqQeRA98mnnVb+E2obWMv96l411GCzyla9bK3snBR0p6R3/JNMrQAqKTIf+e0ClJQt
        z8lFHbmCeMsUl0LZpPA2DblKpLEXeV8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-R8QfUaFVNLqz2zK9pmZSMA-1; Tue, 18 Jul 2023 11:37:06 -0400
X-MC-Unique: R8QfUaFVNLqz2zK9pmZSMA-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a3b86821fcso8005896b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689694625; x=1692286625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFSYW0DOGpPster+jaAtGmVXakx425pOilKzR4Mqu7g=;
        b=Z5pbk6XEpKVqmaTxeJwYEtUjqLOe0ZH/PfMSUELUF2NXoiW6eG61CNbUEJi4q7ggb9
         sLzqWUkB8y85H6tzOYJo9CXkqlOVAoUIR/KxIA/GF3G81Htyrt4/waj9Q1G7CPm1kzum
         2U61NiOq/jSx6pnfhz08QwNgeALIhvfnwFalylMmuR56x6zECHkzd+gnwYrLbOkahxsF
         rmzpAwFuOVsk48gBoBbOEVM/jAH8wbqjpZHprka1xd5I44ICnsbSgJgESy59fEAghIQa
         4ffvtTe7zfGtESYgbFzg6as8js34yqaExOZBsqdB1GUVt25DqIbAyxZQFsppjnsqWRIE
         XMcQ==
X-Gm-Message-State: ABy/qLZSc/G+l+pAw7EyQEtwnSdamyU2N4ycPfIAg/dIdj+TToa7U701
        5iBPknQ/dQ7jsvqTIo1pt4v58eDd3m2RwrJ7rwxReOntNkh+BjBVDPtxXT1xleMWKxeilJBvlON
        8mY+16B1UODZHejGcSMu0aEvIGOcqON7eM0Z0huXn
X-Received: by 2002:a05:6808:8dc:b0:3a4:2941:6c4e with SMTP id k28-20020a05680808dc00b003a429416c4emr8358188oij.14.1689694625695;
        Tue, 18 Jul 2023 08:37:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEf9mgh2Nt7cWxiKa+uMA40DWO59oOanYv0EqBNuG6J62s4TTbWO3ymUHzb1Pts2sn8rpd/wCp6KZ9iqWw7z9M=
X-Received: by 2002:a05:6808:8dc:b0:3a4:2941:6c4e with SMTP id
 k28-20020a05680808dc00b003a429416c4emr8358177oij.14.1689694625367; Tue, 18
 Jul 2023 08:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <CADDUTFyArtN--_27xLWpqnBM2e_udmL+E6Ka7KgimTUOguWthg@mail.gmail.com>
 <87ilaiwsyl.fsf@meer.lwn.net>
In-Reply-To: <87ilaiwsyl.fsf@meer.lwn.net>
From:   Costa Shulyupin <costa.shul@redhat.com>
Date:   Tue, 18 Jul 2023 18:36:54 +0300
Message-ID: <CADDUTFyYxh6+-+uhiVYXcPvS+1qQ6XYG_y4J5Q9uLwhcuZp_4A@mail.gmail.com>
Subject: Re: confusing changes in the documentation table of contents
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, kernelnewbies@kernelnewbies.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

> By "table of contents" you're talking about the left column?
Yes, on the left. Now it is named "Contents".

>  I agree it's still far from ideal.
Do you have any prototypes as examples or in mind?

Costa,
Thank you

