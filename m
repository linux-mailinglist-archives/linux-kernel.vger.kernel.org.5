Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77877941CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 19:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbjIFRBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 13:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjIFRBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:01:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518221BB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 10:01:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68a410316a2so75788b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 10:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694019692; x=1694624492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgPN5RmmA1Doz2MUm5n36iknKd9POJzDYOXRAJnYbJ0=;
        b=oQq8T3cNjvT19XkrjOh0kpILEFlSj3m+iSI7iCHoy25YHRUaeS5PefbOOn0l40Ug1I
         bK+7v8COiizo1wZz0LVAXTwoWdwt6PX5YQLIamQvbufBg2CnP/49BGsDNiBPEMP+jJDv
         bHkRSDcmXbZXlvkHpXbePA5WonLD2wkja9NZbjezdxhqKcI3w0h8ksnLfAdjaCwlHS/K
         W4HznY7egL8ne/2Pw+Xb+tUI5T3W1YvB7Y7t/J7PjmX0CxGDNavS0jZN82bYTbwi81Ie
         SpueoxKFLQEG+8XsDf4Pg3PK4TTpSLgtqOn4308ZOmm56wVaAWCfjEHePw91U+Jacsfp
         UHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694019692; x=1694624492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgPN5RmmA1Doz2MUm5n36iknKd9POJzDYOXRAJnYbJ0=;
        b=a0R7HM42mvl8nK10oejZAGmFfIojJAUGExv3+bmGxMOhM0pVit6HIF4QxqoytoCp5N
         n4w9W/wsUnvzaZdkwkEmsbAHhF9SkvtpsK3bwSLSv6HCl+3e8Wm2fIGxkSbnnXx9flon
         yCgsI1b+5yIzqfvqFxUcHVTN7qw+MacDFdt1o/jtgIxA0Ncz9C9kvfCqjLnOMy9zH7aA
         mhbu04S4NvRTtCSp1++K8qVuIfKw4T5IPGTcfTMSn5Nwu/SesfbiPcKxP2osq/LRDkj3
         OaBATBE6X6fdPd9Z4KU0ddKK9SN88sEooOe5bGH4HGHTnDx991hlHMYtb7Jf5WAvazzN
         mZ8Q==
X-Gm-Message-State: AOJu0YyWOMB3AHN3bN/d1PmDYxgVKCfEW92JKx4ik5HzP8982C0fC1pq
        buJevp/++/JOZZ9iojfl2qo=
X-Google-Smtp-Source: AGHT+IEPETRZvtt22QYuozA+Vct++KXETst9yUsd+5iFCRh/fKGK/GnXnthVW5AQPO9GKGU+XMjAaQ==
X-Received: by 2002:a05:6a20:9759:b0:10c:7c72:bdf9 with SMTP id hs25-20020a056a20975900b0010c7c72bdf9mr13309426pzc.29.1694019691528;
        Wed, 06 Sep 2023 10:01:31 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:eca7])
        by smtp.gmail.com with ESMTPSA id y5-20020aa78045000000b0064d74808738sm11072515pfm.214.2023.09.06.10.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 10:01:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 6 Sep 2023 07:01:29 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Fix UAF report by KASAN in
 pwq_release_workfn()
Message-ID: <ZPiwaaZaDPVexezn@slm.duckdns.org>
References: <20230902115026.13460-1-qiang.zhang1211@gmail.com>
 <ZPd4yKqbvBNGV7cL@slm.duckdns.org>
 <CALm+0cVf+E_Y41AdEwLjm2gZAjzeKaZev1Tu1hUS-VpYH0eEHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cVf+E_Y41AdEwLjm2gZAjzeKaZev1Tu1hUS-VpYH0eEHQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 10:12:34AM +0800, Z qiang wrote:
> Flush the pwq_release_worker is insufficient, the call_rcu() is
> invoked to release wq
> in pwq_release_workfn(), this is also asynchronous.

But rcu_free_pwq() doesn't access wq or anything. The last access is from
the work function.

Thanks.

-- 
tejun
