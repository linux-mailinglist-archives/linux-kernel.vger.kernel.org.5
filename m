Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4034F76F4A2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjHCVdc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Aug 2023 17:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHCVd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:33:29 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B5030F6;
        Thu,  3 Aug 2023 14:33:28 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-56d26137095so221568eaf.1;
        Thu, 03 Aug 2023 14:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691098407; x=1691703207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxDBxnydXIKULCGw16VLgluyX4PiOqgdFR/1k2FuUpw=;
        b=WCk6H5is1cozqWbwe99PgFj8Qr0BoJxA7CSVsH5yDK1AxdDWdwCgrYuQZJRo/ifyhG
         5Dcmln++SSX7iu1QmFmK4Ky7NEiukOlSTPEoHoMzyvoCBOxp9MbHvgElzaQqvt6iQkBL
         3k7jVFtCiHwQkWuWovk0OWIKGRyLfIQSGUcXgJRZXdI9NpL0pgejupi+7QIXBpS19Ryc
         X4oB64vSNFMAO9RxQ0H7PgCuEmiS44YoPXmmF1Pb4ewIEf02DHrQQZsZAevMo+qw5Tjr
         2Dec9ud5e0A4RXZAkeEGr7EYiX6+9eGHMIvpU3g2sqs+1z1u0MHnkYLafbDDswI2eXN9
         WFZQ==
X-Gm-Message-State: ABy/qLY+sm1bRJ3FxH451hGdvBiqbCy1kQfd7ctMrQhfyOpWUDXIyxjt
        x59rJ4WY8IgklDihN5Q0SKuuQpusnCOfNfG97V8M8y9ytAI=
X-Google-Smtp-Source: APBJJlHihFyxS3t9KRLOOz6GLeQSUjpA7waCA29yNp/EVXD3AJjMoF6GasI53AhSN0/wg9nFt2Nw/xAvTOL5vZwZMhk=
X-Received: by 2002:a4a:d027:0:b0:563:3b56:5dc1 with SMTP id
 w7-20020a4ad027000000b005633b565dc1mr12204145oor.0.1691098407181; Thu, 03 Aug
 2023 14:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <5712331.DvuYhMxLoT@kreacher>
In-Reply-To: <5712331.DvuYhMxLoT@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Aug 2023 23:33:16 +0200
Message-ID: <CAJZ5v0jTG-oqV+misnP-=W5aq0S9X631kW9EhKNEn1VJQqwL2g@mail.gmail.com>
Subject: Re: [RFT][PATCH v2 0/3] cpuidle: teo: Do not check timers
 unconditionally every time
To:     Linux PM <linux-pm@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 11:12 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Folks,
>
> This is the second iteration of:
>
> https://lore.kernel.org/linux-pm/4511619.LvFx2qVVIh@kreacher/
>
> with an additional patch.
>
> There are some small modifications of patch [1/3] and the new
> patch causes governor statistics to play a role in deciding whether
> or not to stop the scheduler tick.
>
> Testing would be much appreciated!

For convenience, this series is now available in the following git branch:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-cpuidle-teo
