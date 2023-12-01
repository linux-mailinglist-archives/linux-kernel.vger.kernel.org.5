Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A0D801135
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378625AbjLAQ7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjLAQ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:59:43 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F47106
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:59:50 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-285b3a14b12so2140579a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 08:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701449990; x=1702054790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+HE4G/M4xxYiKysGfcg2/z2HVdiLx1XnANJ5af98uk=;
        b=L+yFf7HogqXevwszuiyoVTWCYlxWR0q1k7si501hFalw74MVMCKgP+t5UBBoGSSxSG
         +oScu7wfrclreiF40j2MCaYgVvswWcLjUXoPuIbiENLEZGC+HvoMKKTCrG9nF43sV90z
         k5PhunBQgyU3B29Bl8VC0AmO8KtgfIHnoJ1+UhvaEJABDOC7jiZZRXUySDoq/WeJ8s5j
         PND71WX0YpQDX+cQcBX7ENvyZrOqNmUx2IWs3OnIXFRtXil8pjg5C7R94p80Ga8BN7qK
         REmOkcdi2sXjXMBq3kTEnWQlxqbQzix30c2VNQuPpnVpFkIe/HB2Rz3oDd7zJoadSMCT
         dx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701449990; x=1702054790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+HE4G/M4xxYiKysGfcg2/z2HVdiLx1XnANJ5af98uk=;
        b=SZVf3J6OTKKdhH/1paE9MnAx2iWPLmpWqV/FPMLh6yd2TXTdWmNrIOVbZJI8MQPITX
         b2o2/jWJdmshS2VRdVw0kpiVRqIrK96Kk7RYbM5nznxIqyvlMu/n/X+jnBsmcK9XO6Uq
         PI+HjWjkgyfeEtPVZhIef7I5JN902vZF6xlktg4a1XVqLiJy8hMsrWHqatc9NRKf/91i
         IR47zwpDDhcSyiL4jr7xeX4dF33RLjHYQwEhJAOtGU/WZWZv4iAbDOY34Zg9QbymXS+t
         q1bA9m3WyS0k5wsYzV/DewY50pSj9N9ljVrxBYQlmoXic41AB3TII2ziTlwsUsBTVqu2
         mnAg==
X-Gm-Message-State: AOJu0YzCUBmdLbeZw2L7ds4I8iLQKzYIa3A2Imu/jWCeTnDLm99yLsWV
        f9TwUAtuUpX1FQJB5jc5OJA=
X-Google-Smtp-Source: AGHT+IHkYKfJafg/yEZJQN0H9f6ZWpvhUhEZHmDHMKosrgZkb9pRnFCq+wbMvH0WVjganlzuBaci8g==
X-Received: by 2002:a17:90b:3ec2:b0:285:9833:d18b with SMTP id rm2-20020a17090b3ec200b002859833d18bmr23383583pjb.3.1701449989808;
        Fri, 01 Dec 2023 08:59:49 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:27ef])
        by smtp.gmail.com with ESMTPSA id j3-20020a17090276c300b001ce664c05b0sm3564829plt.33.2023.12.01.08.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 08:59:49 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 1 Dec 2023 06:59:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs/kernfs/dir: obey S_ISGID
Message-ID: <ZWoRA52jPacJCiqs@slm.duckdns.org>
References: <20231201125638.1699026-1-max.kellermann@ionos.com>
 <20231201125638.1699026-2-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201125638.1699026-2-max.kellermann@ionos.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 01:56:38PM +0100, Max Kellermann wrote:
> Handling of S_ISGID is usually done by inode_init_owner() in all other
> filesystems, but kernfs doesn't use that function.  In kernfs, struct
> kernfs_node is the primary data structure, and struct inode is only
> created from it on demand.  Therefore, inode_init_owner() can't be
> used and we need to imitate its behavior.
> 
> S_ISGID support is useful for the cgroup filesystem; it allows
> subtrees managed by an unprivileged process to retain a certain owner
> gid, which then enables sharing access to the subtree with another
> unprivileged process.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
