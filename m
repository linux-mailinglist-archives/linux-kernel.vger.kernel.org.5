Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E233F7AA4CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjIUWVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjIUWUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:20:43 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0455B96
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:08:50 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c0b8f42409so724759a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695316129; x=1695920929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bZ1DObAEllNfzNC+iAQHCqhiv+DRdfXl9I07x7RRLQE=;
        b=LHy8osrU0sR+eseJ7977/FKGz5NW2VBR5t7LlebS7A6ns0mQYqppAE/Qdb2UcpXnlL
         XvwOn3B7SFHNcDdsB4b8mJtuq3wKgJTh/59TppPoCS54Sm3chqaUi15RwlV0DXy5IzG8
         fm7C8w3NYGgM3k0f9LotkhIj5o5IFna0THMiHFqcIj2RnG4WwecZA8SUndRHpgvnomV3
         AUxqpschHIKpU158kH2+MwiZCTqLR+DrULt31lopLxCtoHACIC7Xa9149osvn2UIR1dU
         PKmT/HzK+wHmQMYgvN/+4eYTAP3pXRbZr2nng93caekr4xDQlcQRnPz8Q4OZ6JQs1lVR
         iYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316129; x=1695920929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZ1DObAEllNfzNC+iAQHCqhiv+DRdfXl9I07x7RRLQE=;
        b=k1rlWfzXCpx0Xu+/NxGSNgJsQcJjdQnVTEBH9neQ5XETv4cypgh6FVxm6eZz2YyRbj
         jjFhQ3dqKsnmiDd0WYduk+yTOJ2K6nJfUwGMhVJR1/3NfTm94Dgtc+xt1OX5LjvT+GTk
         6fx8a91u6dNprEjLM4/3QR6q3OVmNyBD+14ZCPnNONiUd92eai+jFWMVXHy1WUP/Uuc1
         MOmOae1B9avKGy7gvzxfwgiSipph4mU8oVNYMrodIrVQtGUI1dLtCrpB3u4dp+CZfUJ3
         PolSeNByJoKnKOjLnendOQkkCazEhgj2gOWEDsGcWA4EV9E1tGrkZWNwszajNFy3ihdP
         SzIQ==
X-Gm-Message-State: AOJu0YyQhilJRjSwaZIsvthmIPRSASyRE3lrYt9XpMRQ27LLo5NrK79i
        auIgrO1finklhDAWJ/rRzOdh+GC6aOtIaIQFBQiiknHTKopMAWlUJqlXFQ==
X-Google-Smtp-Source: AGHT+IFSGJaxXF7ToqoVOPRbkYcmEl/mV0T5KxbyVeB6FJYCFB3wttjUFy9TuM2v1nUqZCmGpzeZQy3GL5R+9ksXKiI=
X-Received: by 2002:a25:68cb:0:b0:d43:18d7:e292 with SMTP id
 d194-20020a2568cb000000b00d4318d7e292mr6189141ybc.32.1695314376936; Thu, 21
 Sep 2023 09:39:36 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date:   Thu, 21 Sep 2023 18:39:25 +0200
Message-ID: <CAAi7L5c+7UoCOmKHAY4E1w_pwDS=qVOGsO+tfx6e3Zu+kyxHig@mail.gmail.com>
Subject: Loosening time namespace restrictions
To:     linux-kernel@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I faced a problem with the current implementation of time ns while
using it for container migration. I'd like users of CLOCK_MONOTONIC to
notice as small of a jump as possible in the clock after migration,
since according to the documentation "this clock does not count time
that the system is suspended". In that case the formula for clock
monotonic offset is "m1_monotonic - m2_monotonic - migration_downtime"
where m<n>_monotonic is clock monotonic value on the n-th machine.
Unfortunately due to time ns restrictions, I have to set the offsets
before putting any process in the namespace. I also can't move
multithreaded processes between namespaces. So I would have to know
the migration downtime before the migration is close to done, which
seems impossible. For that reason I'd like to drop the requirement of
having to set the offsets before putting any processes in the
namespace. What do you think? Is it possible to implement this and get
it merged or should I forgo it? If you think it's possible, I'd
appreciate any pointers on how to get this done (or how to solve my
problem in another way).

Thanks,
Micha=C5=82
