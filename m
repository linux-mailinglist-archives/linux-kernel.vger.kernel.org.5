Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CD87D53C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343689AbjJXOUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343640AbjJXOUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:20:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA2AC4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698157175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6LHDAQ5bt6PFREmfdQqDTjLBVx5CvlJgpZKTKibBhzg=;
        b=gWW+9fvof1uFkS/5gM3wqBDv22nbbL6NhNpRkyMfRS6FPhaeS9oR383m8vJTKLvni+54wY
        2gg4+r/fOTNUpNhzMHe1KUcTv38/mhA4ISpXrLovAAUuF57PCqIlA6+VK3hsAAsIHuG0fF
        B/Ul0ryKluC20ioBW2kD57Zd4+Ocwtc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-SXA1R8F3N-SoOsdrO49vxg-1; Tue, 24 Oct 2023 10:19:34 -0400
X-MC-Unique: SXA1R8F3N-SoOsdrO49vxg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-69eac5ffc69so3443324b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157173; x=1698761973;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6LHDAQ5bt6PFREmfdQqDTjLBVx5CvlJgpZKTKibBhzg=;
        b=DR2H+BR1VSXbv9l6ipsRaVRMzJU585QddM5EX82T/1qnGqcKAgZFEC8TZ3RHcKXY3Z
         ysuHFP5shl9hQXpyQYWbK7J+S78btHyRVZpV9ZskQahdnqx5Ke7zBk52xozQBJ6TT2oR
         xLVFxvnuACPQSv52FQiAr2cZ505LjQtBRcAch7XXEYxmYR74XsP6WrJw5ObI5PwDWWf7
         jYcLRCzp+8YL8xoKSQTcu7LsNLRIKWNHmLfuef5rX3fYAnOzGTv2bSuDmXEx3c9NXIGK
         uvMggRul+P1PH5LP4uC5gFvPXIwMD3EKZy49CSAruW4tH8UJHbl7iBarl5ou7HXFZfM2
         MQwA==
X-Gm-Message-State: AOJu0YzIhmGk8g0HDgpr93zaXgZd7hyfEabv/frb23MecEoIF2qLOyDH
        IqO5YBrkB/jp4b7MfwP3H4h8Bw7PlblDS9TMeqS3oH0O+dtCSdEImKSpARaFCaQYrqAIAG4tD/T
        7vfcyOthb/icLiDwQwlz1b8aA
X-Received: by 2002:a05:6a20:430e:b0:14d:6309:fc96 with SMTP id h14-20020a056a20430e00b0014d6309fc96mr2988410pzk.4.1698157172718;
        Tue, 24 Oct 2023 07:19:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGQWjZoTCfvmq4HN0bJjupcjDugD8G2wluUAPe8rRtnQ7V2omOYmSs6F7du1qO6htcvKSzAA==
X-Received: by 2002:a05:6a20:430e:b0:14d:6309:fc96 with SMTP id h14-20020a056a20430e00b0014d6309fc96mr2988387pzk.4.1698157172436;
        Tue, 24 Oct 2023 07:19:32 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:f0fd:a9ac:beeb:ad24])
        by smtp.gmail.com with ESMTPSA id z64-20020a633343000000b005898a3619c7sm7128844pgz.48.2023.10.24.07.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 07:19:31 -0700 (PDT)
Date:   Tue, 24 Oct 2023 23:19:26 +0900 (JST)
Message-Id: <20231024.231926.1671064705010862132.syoshida@redhat.com>
To:     kuba@kernel.org
Cc:     jmaloy@redhat.com, ying.xue@windriver.com, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] tipc: Fix uninit-value access in
 tipc_nl_node_reset_link_stats()
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20231023155314.50b13861@kernel.org>
References: <20231020163415.2445440-1-syoshida@redhat.com>
        <20231023155314.50b13861@kernel.org>
X-Mailer: Mew version 6.9 on Emacs 28.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 15:53:14 -0700, Jakub Kicinski wrote:
> On Sat, 21 Oct 2023 01:34:15 +0900 Shigeru Yoshida wrote:
>> Link names must be null-terminated strings. If a link name which is not
>> null-terminated is passed through netlink, strstr() and similar functions
>> can cause buffer overrun. This causes the above issue.
> 
> If strings need to be null-terminated you should switch the policy here
> https://elixir.bootlin.com/linux/v6.6-rc6/source/net/tipc/netlink.c#L91
> from NLA_STRING to NLA_NUL_STRING, no?

Thank you so much for the feedback. As I'm not so familiar with
Netlink, I'll study NLA_NUL_STRING a bit more and make an updated
patch.

Thanks,
Shigeru

> -- 
> pw-bot: cr
> 

