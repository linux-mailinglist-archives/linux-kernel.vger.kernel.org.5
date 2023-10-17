Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280CD7CC2C9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjJQMRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343676AbjJQMQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:16:49 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599274211
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1697544993; x=1697804193;
        bh=KRuOAkjZGIG2r6IHWGXC+XJV7uOGD+ibR185OeoHuMA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=k3UmlNWn5P5Td8hjdwUp95U4IftjG9+b1n6Oiiu5y1ewdu6gkeC0vRe/3qPTlOkg0
         0GaftVq2ZVI3j+GXD7LQwqpRlboVcaLHdDverCZGYOUqwq81NVSW6Fi0oUApbh28nF
         i5qy8AslUqpgNwNTo0WfogygI8zFBkf8Xeqp/ZYTwYuOvW4fCLpr71l23eQFKEpX4I
         9SAoY1bPfegihPTKLs18xreecaBmDyBScWu/VVdBRyIat+JJWp4FAEz7NHXVGhmxOO
         LCmMg/cORkdaacYCvjRmRzAHCC9v6xPELro2ssWget9xFDw3aPdMbKZ73PVtvRdG5x
         WNZdIFH+yxLjg==
Date:   Tue, 17 Oct 2023 12:16:20 +0000
To:     =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, pierre-eric.pelloux-prayer@amd.com,
        =?utf-8?Q?=27Marek_Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pekka Paalanen <ppaalanen@gmail.com>, hwentlan@amd.com,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, joshua@froggi.es
Subject: Re: [PATCH v7 4/6] drm: Refuse to async flip with atomic prop changes
Message-ID: <3r5-_03WC5dK3LaRt1Is78zD_bmT2aaGc5h9jpUGzo2o5GCtGP1zpQNzUxglsieewFklY7xwTrOS9jtI18YlNnnzHNx2Ccw9yM2NuJpDQZU=@emersion.fr>
In-Reply-To: <CzEtDALWvF3EU4DDLLEmH3ms0B25PbsEHRU9b_IqwfyhzdG4zC-XXAU6fm2PnMcngAYmntH7s4iuew0vocN6cO8zUit8kgi-Sb1hBQXNYiw=@emersion.fr>
References: <20231017092837.32428-1-andrealmeid@igalia.com> <20231017092837.32428-5-andrealmeid@igalia.com> <CzEtDALWvF3EU4DDLLEmH3ms0B25PbsEHRU9b_IqwfyhzdG4zC-XXAU6fm2PnMcngAYmntH7s4iuew0vocN6cO8zUit8kgi-Sb1hBQXNYiw=@emersion.fr>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After discussing with Andr=C3=A9 it seems like we missed a plane type check
here. We need to make sure FB_ID changes are only allowed on primary
planes.
