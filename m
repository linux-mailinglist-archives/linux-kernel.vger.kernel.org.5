Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1BD776D56
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjHJBDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHJBDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:03:05 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C290DA;
        Wed,  9 Aug 2023 18:03:04 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76cc4d495deso20083985a.0;
        Wed, 09 Aug 2023 18:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691629383; x=1692234183;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mjbct6+NhYkuAjSPW71HeXPfYDJMs32vBynrYKuLGIc=;
        b=Taha99DDuoFyNMzceUKpf8q8B5PSYaQDIkiasRM9UwUvmgLDh275EEsSTycuw9+XKE
         JVzi3kB7RRWvnpxCLopWgPLWtoJyqbiD6r2foqebscKMqTHsa7UMFAM4E1ucUhK0kT9V
         nsgwdRTFV8DFVW3Na0O9a3Nidv/lF4tVOZIYFOEc3pAf235DKXH/I4Yc4N8JKIRdNaIp
         SlT6ZrEqP6EtDL3dDzN6jPHjcp/rBPbdh0kuSFVwwCC2wceKOaUkddEynlGw1S+3T34i
         trWJTG7SNXnPkF1a2VQzV/fywwxmAKbqnlXAwUWHFfbLgxACGnrmOib4T2CA2Mdwa9L1
         gtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691629383; x=1692234183;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mjbct6+NhYkuAjSPW71HeXPfYDJMs32vBynrYKuLGIc=;
        b=A19WJJW7nCgnbpjXKFUcQ77DpAWeWc6jiG3MF9UaMzDrF23AFtLRWNHqaFFMgb8Mjx
         4RNUTPQn+5Lfg32bnv9gxWq51n80fhPmc2kh1SRZHf7kYP9XArRan1yoYqgfk/r2D7TT
         0jt0fg4w7qRYty12tE9RGfO+AYeghmb+9+nr+1puxg0ADywxfCv+ud2u2dmpmm9o4E18
         GQt1+NMxr5uoioWmSaPbGNHmKC1zV2obyv53Jah9g/IhD8slviJeA+GuOpo85g8wJ33a
         Yv77OhTTTSsl2pyvZPa/4IB9h9+rzRLmquCaDcJgaHeHttYM1kPzbGFsjpBEx2VaQY3h
         Zs9Q==
X-Gm-Message-State: AOJu0YyG3pnqx5d5gZ7/3y/iqI7PQwIU5RRj8Rsg/ac5H1wOezbXSxpI
        EqlMHgeLJ0KLHlbyslyXaGs=
X-Google-Smtp-Source: AGHT+IH8jYVRF79dsFAUKbty40sjdBkhuBddmWbOnHlzpa61RglgzoIkbpaS90CWI7pRXttXoTcNYw==
X-Received: by 2002:a05:620a:4516:b0:76c:cd15:a8b5 with SMTP id t22-20020a05620a451600b0076ccd15a8b5mr770039qkp.21.1691629383175;
        Wed, 09 Aug 2023 18:03:03 -0700 (PDT)
Received: from smtpclient.apple ([195.252.220.43])
        by smtp.gmail.com with ESMTPSA id d14-20020a05620a166e00b0076c5ad6750fsm105540qko.102.2023.08.09.18.03.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2023 18:03:02 -0700 (PDT)
From:   Sishuai Gong <sishuai.system@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Racy kb->ledflagstate and kb->default_ledflagstate
Message-Id: <55671A40-B122-4723-B412-B52E30ABA56F@gmail.com>
Date:   Wed, 9 Aug 2023 21:02:52 -0400
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We observed a race over kb->ledflagstate and kb->default_ledflagstate
when two threads are running vt_do_kdskled() in parallel:

Thread-1                        Thread-2
// holding led_lock             // holding kbd_event_lock
kb->ledflagstate = (arg & 7);
                                ucval = kb->ledflagstate |
                                        (kb->default_ledflagstate << 4);
kb->default_ledflagstate = ((arg >> 4) & 7);

Is it better to hold both led_lock and kbd_event_lock under case KDGKBLED?
We are happy to submit the patch if it makes sense.

Thanks

