Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D5F8042C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjLDXqV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 18:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbjLDXqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:46:13 -0500
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19890109;
        Mon,  4 Dec 2023 15:46:20 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6cdd214bce1so5372979b3a.3;
        Mon, 04 Dec 2023 15:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701733579; x=1702338379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2jpvdls81A8CJqvJTCgXPJeqzKz6GPCtnOBOaW0I9c=;
        b=U3xpB5HZ9VRwnQs/y1l18Fgw8ZdLEQX+0ux/rSSfGZbL/s3tXPtnlcXtHzge4zdCaA
         hKW3y2xzQr1z/pLvh+Sh5W3RMBINymJtlo9BwaVjWuUL07q9ZlUX49vpQtac7VN0J2p/
         r2quHohRWynPW74Plus2yNj/W4o1pvXuMYAMZMjKA1chOt0hkkC//6lvueI+KAgC0AlD
         i0us4muQ44/pIMuXEIN2mmysSxJS2ApqJwfU16DkumlqP+P0HqqURNnyLDLOhM4p08RY
         gpsmapSv5TOu2GZ+Gmkw/LVA61re2lNMwwYyvfbvFE5LsFN2PfIwp3aoyYE2WPnthhWn
         Tv6Q==
X-Gm-Message-State: AOJu0YzpaHROHNrQmEIdiOo3h0nBGQNEwG+6d/sAy+xhGiFGlpqO+WYX
        RV+KblDbS9HQFiGHwQO2mMm5pq72ayQw3/HxfGY=
X-Google-Smtp-Source: AGHT+IGrrLXyiZjXe4Pl0rOGsKW6DmdZ5CRCvto0thB4cDvFtnMo9OV3aiTxPA0hOox4lo7b4i+E6zDR9qYIaUUKWo8=
X-Received: by 2002:a05:6a20:b928:b0:18f:97c:8a44 with SMTP id
 fe40-20020a056a20b92800b0018f097c8a44mr4748532pzb.111.1701733579462; Mon, 04
 Dec 2023 15:46:19 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-16-irogers@google.com>
In-Reply-To: <20231127220902.1315692-16-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 4 Dec 2023 15:46:08 -0800
Message-ID: <CAM9d7cgC1TXRF8d0VGt-qE4eKACTHA+JLNt95GLRSSWkZMwA2g@mail.gmail.com>
Subject: Re: [PATCH v5 15/50] perf maps: Add maps__for_each_map to call a
 function on each entry
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
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

On Mon, Nov 27, 2023 at 2:10 PM Ian Rogers <irogers@google.com> wrote:
>
> Most current uses of maps don't take the rwsem introducing a risk that
> the maps will change during iteration. Introduce maps__for_each_map
> that iterates the entries under the read lock of the rwsem. This
> replaces the maps__for_each_entry macro that is moved into
> maps.c. maps__for_each_entry_safe will be replaced in a later change.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

At first, I wanted to have each conversion in a separate commit.
But it's all mechanical changes so probably ok to go together.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
