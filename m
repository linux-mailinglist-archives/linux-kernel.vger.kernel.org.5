Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5227A4012
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 06:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjIREeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 00:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbjIREeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 00:34:02 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF69BE7;
        Sun, 17 Sep 2023 21:33:56 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c453379020so9115405ad.1;
        Sun, 17 Sep 2023 21:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695011636; x=1695616436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTk1MSaSZ6J171Lp0y7vFzpboa0xOh5P3IIZsWDbUIA=;
        b=X25GoB8jetdXrCQXHp36B2gHAEM+EpeiyG/F9VHEUKgWjOjCi+JXC6ICe281DXfpnv
         vXQyuKomhhlqTkip3bOWld3G8rJ7KTemOU+T3cJGz9TQ8qAfgc7/a/I/FoNItUpQP8mN
         gEpFsu81YlkgpfeAG6Es7w0GADJJkWTPKpscCMuKzWd8BJlUwR8i3D8qjTxFVP7PUE9g
         nUOZV+tRrwRmOZ1Q8RMl7sDOkWGnX2GWjQ2dl6w9CC/LLlNOGkFhtaCgTpFe2O54UqoA
         QEwxveiZwPeZHeyRYavJoyDgGGDQvVB1Y8vfMqHg+oDMuEuedASZkZtAYSPW+qXzCXY1
         VuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695011636; x=1695616436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTk1MSaSZ6J171Lp0y7vFzpboa0xOh5P3IIZsWDbUIA=;
        b=Jk7O15I4M4eBLBZhT3gABS1dblLV9mR9Cw0R1cupOWGcT4FC1kX8hzzboYMhggQNiU
         /uO60FDK9GV/JrzYQ77YdG07jqOKB2/wfCWhuojNY4MZ9KMSU1EfvNJpT7OLZV6BEaTn
         7UJHNVQBRyL2kj0/itHBoQ2oP6xijn1fiMMhUCQge8pUFflYPrdjR0/c6rHripmmiSB7
         dKkeaTawx2sJUZiwzbwp2AA8l5Sw7+j2k7Os9OD8dAuFtAVEo4RoWtse5j80kVMzfJUu
         SdPdSdlrSm1FSgDAHdYV0aLfOZdx8MNTuPYaoZC39sH7++/hZa2OuuEaRNCx/n9v8YKC
         rZ3w==
X-Gm-Message-State: AOJu0YzbUOxRIpxDFrB+iRI5yIGdwxlebjgpU9DXECqMAulaNks1J7G5
        AqMxvfNNo44Z72qfe3nV4Wg=
X-Google-Smtp-Source: AGHT+IGR0ozaUZ3KJHjohlSc+QcXO9FQWeIFrBwMg6Xwk6/o0QegFQhpZxQhqUjSIjLOlMmaXwRelg==
X-Received: by 2002:a17:902:728a:b0:1c3:9aa7:66e1 with SMTP id d10-20020a170902728a00b001c39aa766e1mr5909740pll.69.1695011636058;
        Sun, 17 Sep 2023 21:33:56 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001bb9aadfb04sm7319285plr.220.2023.09.17.21.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 21:33:55 -0700 (PDT)
From:   alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To:     david@fromorbit.com
Cc:     alexjlzheng@gmail.com, alexjlzheng@tencent.com,
        chandan.babu@oracle.com, djwong@kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] xfs: remove redundant batch variables for serialization
Date:   Mon, 18 Sep 2023 12:33:44 +0800
Message-Id: <20230918043344.890817-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <ZQJJasg4eIt99t/0@dread.disaster.area>
References: <ZQJJasg4eIt99t/0@dread.disaster.area>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 09:44:42 +1000, Dave Chinner <david@fromorbit.com> wrote:
> On Wed, Sep 13, 2023 at 11:41:15AM +0800, alexjlzheng@gmail.com wrote:
> > On Mon, 11 Sep 2023 07:49:51 +1000, Dave Chinner <david@fromorbit.com> wrote:
> > > On Sat, Sep 09, 2023 at 03:17:51PM +0800, alexjlzheng@gmail.com wrote:
> > > > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > > > 
> > > > Historically, when generic percpu counters were introduced in xfs for
> > > > free block counters by commit 0d485ada404b ("xfs: use generic percpu
> > > > counters for free block counter"), the counters used a custom batch
> > > > size. In xfs_mod_freecounter(), originally named xfs_mod_fdblocks(),
> > > > this patch attempted to serialize the program using a smaller batch size
> > > > as parameter to the addition function as the counter approaches 0.
> > > > 
> > > > Commit 8c1903d3081a ("xfs: inode and free block counters need to use
> > > > __percpu_counter_compare") pointed out the error in commit 0d485ada404b
> > > > ("xfs: use generic percpu counters for free block counter") mentioned
> > > > above and said that "Because the counters use a custom batch size, the
> > > > comparison functions need to be aware of that batch size otherwise the
> > > > comparison does not work correctly". Then percpu_counter_compare() was
> > > > replaced with __percpu_counter_compare() with parameter
> > > > XFS_FDBLOCKS_BATCH.
> > > > 
> > > > After commit 8c1903d3081a ("xfs: inode and free block counters need to
> > > > use __percpu_counter_compare"), the existence of the batch variable is
> > > > no longer necessary, so this patch is proposed to simplify the code by
> > > > removing it.
> > > 
> > > Hmmmm. Fiddling with percpu counter batch thresholds can expose
> > > unexpected corner case behaviours.  What testing have you done on
> > > this change?
> > 
> > Hi, Dave,
> > 
> > Thank you for your reply.
> > 
> > I have tested the patch using _filebench_ and _fio_.
> 
> What about all the ENOSPC and shutdown tests in fstests?

Sorry for the late reply.

I tested this patch using xfstests last week, and all enospc and shutdown
related tests passed.

> 
> If you haven't exercised ENOSPC conditions in your testing, then you
> haven't actually tested whether the new code can accurately and
> correctly detect ENOSPC conditions....
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

Best regards,

Jinliang Zheng.
