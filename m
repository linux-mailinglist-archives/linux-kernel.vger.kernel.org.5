Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663F277E1CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243107AbjHPMm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbjHPMm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:42:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB502110
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:42:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-26b4dea0000so2511426a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692189746; x=1692794546;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lAJXx3zuvSUSvm1+zrkqCECfcvDo+O7F4875vOACYRk=;
        b=j7Ox/IcgLbYiNCnKkA5P1aW1n6BF0hnr145B3ZN4i/TepbcJL0fIK1M54uaBORNhZy
         P9SLJn0HlXa5Lp7YmOigzV4PtiOVuN+XIrZyatwAJaOjlpN96THrEcau9Og5I1so3N1s
         Eg9xmL3aHJqrWT8Cf+t2sIDwVyH1SowSHBj4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692189746; x=1692794546;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAJXx3zuvSUSvm1+zrkqCECfcvDo+O7F4875vOACYRk=;
        b=Sq8LEskzZT5EFzWfGJVe9coNTmZbJD/jDmVqmdZJxzdHjRpBnJoZBQ9f+LYu2ATEGu
         xfCyU4lplVjZahtqcoplNS3y7lAgdiHRraldYZf+9FrSsGfkWkCjEaOswIsQDlcufTGI
         TARSm0OuL7MWZvWHnhkMltEH6FuUf6R6w7CQklCeSFS+Rv8q+heYtrf5zQwhnx1XGv/8
         ylzm/maIs7DX/l5qdQ5XNycTqbsx/7vKbKIt4r3BWCvT7R29l3QQDWUNBxw4GUSzjsSF
         eimHO46y1fMPS51UqLfj8RAgbmQ5BmxCCxEbqfgE7arjSNyTJdOolOuJcsRyjH5Ogq5Q
         2NBA==
X-Gm-Message-State: AOJu0Yz7KPFh1BIdHqsyY3x8BGg4EfJu16eoA0lqBi8zaf8Ao8K9QcqI
        exJY+05u0/ti0uOIRn11AohbZQ==
X-Google-Smtp-Source: AGHT+IFskuvVotxrDIdmeP91Bzepe2AtmyMh5/G4MEmMxSOTDyx2oIRxeNV0PaPKOnRnkSqNq1kLHg==
X-Received: by 2002:a17:90a:9f85:b0:268:34b1:a5a9 with SMTP id o5-20020a17090a9f8500b0026834b1a5a9mr1463552pjp.8.1692189745793;
        Wed, 16 Aug 2023 05:42:25 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id bk18-20020a17090b081200b002680f0f2886sm930591pjb.12.2023.08.16.05.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:42:25 -0700 (PDT)
Date:   Wed, 16 Aug 2023 21:42:21 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: kconfig: list unknown symbols in the old .config
Message-ID: <20230816124221.GH907732@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We recently were hit (unnecessarily hard) when after kernel uprev we
figured that something wasn't working. The root cause was a rename of
the CONFIG_FOO option between kernel releases, which make oldconfig
doesn't warn/notify about.

Would it be possible to add either a new --listunknown mode to conf or
to somehow make it conf_warning("unknown symbol: %s\n", line) when it
reads a line from oldconf that it cannot sym_find()?

That would save a ton of time.
