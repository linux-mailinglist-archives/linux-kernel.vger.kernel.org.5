Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103CD7CD6CE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjJRIn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjJRIn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:43:57 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CC1C6;
        Wed, 18 Oct 2023 01:43:55 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9d407bb15so55532475ad.0;
        Wed, 18 Oct 2023 01:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697618635; x=1698223435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAr4Czs1Gmv7dgWfEmdHDDt8I2NpUA7OGZmt8fiF/E0=;
        b=QgMXQFA9e4+m0u3jKiJFFyKnc4p7AxhbnczkydbxRSjqwUaf6Tgj8Dx2NOHGSczpHD
         yn/8EX5fbv1r+7ct52nITw7LxZGoaz/0bFdbuQ4znQxTDxUMOPWQ0ohAB5h8huo7LcAG
         CSxD4ku/8xpCA/pKbeWIpAI/gIjvnvtZYREBmz6ZoKJUBpv+oiOTgHcSx9mAkTFLVN45
         ciDnj2LerZNGctupfGH0Ik0CfG3m5DN1DbQx7SK4H8HSed8b/AnV9ja4Cmf8S5ECoaMu
         RB99mMm2KUg3jiWmks+T1twhlK5ZZaPJYnS81Pw183qkLWSOE12CUjFaxXahEgoaBQNh
         gr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697618635; x=1698223435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAr4Czs1Gmv7dgWfEmdHDDt8I2NpUA7OGZmt8fiF/E0=;
        b=nIz/DiC9E+X4+isuLLmo/NIhFBpraflRFhzdYnfQLde0CszSonXc46qcJ/mrNN51Ry
         I3q1VyDoAkq/ZAjhsZ4J692uaZHi3kDcQHi0pkpw3pkU608z0o5Mgq+TCSGcNOlynGVu
         NU9fx9GsC5Zld5gI7ZL6UV//sREEeazaiJuOtgNTNhcy5yJT8MpcftLJ8MJ+93BJNK5M
         t/nQxiehFWA/JR2d65MJTGKtXe6S41X+5aNjKkHYAsCTsbeOuCAuarqfpGoGVzG+RfmN
         ovFSCkJdsiOsRDGrLmXk1yBH28/HCHwQN7srWgXvQgms0BMdGztBy9qEokn2XV66FGmq
         0vOQ==
X-Gm-Message-State: AOJu0YyN/jtwSHtdt8tR18hJ/d45NqDuxpbT5N+T25tlCFv+bmbb4hvY
        1Pelm8sdW8q16bzqhy0xnqw=
X-Google-Smtp-Source: AGHT+IG9r9bT1AXckrnxG5oN5+oChhVpMiXvwpGVI5YME+Fe/zKTLdnxRiBZ8kmFxj8PaxCAtPWQzA==
X-Received: by 2002:a17:902:e74a:b0:1c9:ccb3:2352 with SMTP id p10-20020a170902e74a00b001c9ccb32352mr5994017plf.12.1697618634960;
        Wed, 18 Oct 2023 01:43:54 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id k13-20020a170902760d00b001c5fc11c085sm2941357pll.264.2023.10.18.01.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 01:43:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 17 Oct 2023 22:43:53 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     guro@fb.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v2] writeback, cgroup: switch inodes with dirty
 timestamps to release dying cgwbs
Message-ID: <ZS-aydAgB5SIkHyk@slm.duckdns.org>
References: <20231013055208.15457-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013055208.15457-1-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 01:52:08PM +0800, Jingbo Xu wrote:
> The cgwb cleanup routine will try to release the dying cgwb by switching
> the attached inodes.  It fetches the attached inodes from wb->b_attached
> list, omitting the fact that inodes only with dirty timestamps reside in
> wb->b_dirty_time list, which is the case when lazytime is enabled.  This
> causes enormous zombie memory cgroup when lazytime is enabled, as inodes
> with dirty timestamps can not be switched to a live cgwb for a long time.
> 
> It is reasonable not to switch cgwb for inodes with dirty data, as
> otherwise it may break the bandwidth restrictions.  However since the
> writeback of inode metadata is not accounted for, let's also switch
> inodes with dirty timestamps to avoid zombie memory and block cgroups
> when laztytime is enabled.
> 
> Fixs: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
