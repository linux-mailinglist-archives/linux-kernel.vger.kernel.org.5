Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650E17E9D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjKMNdJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Nov 2023 08:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjKMNdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:33:08 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D0D18B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:33:04 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc3ad55c75so46317195ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699882383; x=1700487183;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB/kuL7vFT98LZmFF91gvWSL+IxDP4W37pGpBzzEqVk=;
        b=AoxjK2+B41BWtozLmRJq6F/hDzlejSc9GfVNjQDAvloSCVjLhBd7Lm0zOsfBczQL+E
         6pfbxDt+KzHa0TD2SNybs0agU3k1Wxc27UuvBviaue8YNXkMwcfIKe0vKU7RPDp0ft1Q
         v9ODiwGC13Iuu0+UvxPu9nkllRbezHeDpA/LvHWKmRGTNT6cM4/TkpwHHw6crPBlNDvi
         X0PdW9Dx9wbLYfEDHHq8PEjtW2j8SFKPgTJZrpqZdFp2V9VCRBTV6FGS3RgfaVhp3r83
         36jsPS/zfJKE6kRRGWpAygOtCCJmlnY7mwz6TlgmD5dfSw+OtiN1zSvbQduVqTy4Pd90
         tgbQ==
X-Gm-Message-State: AOJu0YwNJnuncXN3S0cpAmmPcjfPnIac+1hHhzm17fve5ZycT2UjEVeS
        zjpjKLEx7vvQ48z0i80utqsF1hF6EHNFFOxN88FdKUmdtnaC
X-Google-Smtp-Source: AGHT+IHoH4RkKf5R6bXhUl2xzABwW/H+21wb4up6JATs/YraPvWwco/JudetL/R8CkjbxaXfq/gdHA2MM5i9E9gIl0Wxw/1mTMcz
MIME-Version: 1.0
X-Received: by 2002:a17:903:25cf:b0:1cc:323c:fe4a with SMTP id
 jc15-20020a17090325cf00b001cc323cfe4amr2024518plb.12.1699882383722; Mon, 13
 Nov 2023 05:33:03 -0800 (PST)
Date:   Mon, 13 Nov 2023 05:33:03 -0800
In-Reply-To: <d9657547-fbd2-43cc-ba78-e1cf308eb954@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4540f060a08b52a@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     code@siddh.me, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to create VM pool: failed to write image file: googleapi: Error 500: We encountered an internal error. Please try again., internalError

syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs-2/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs-2/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.20.1"
GCCGO="gccgo"
GOAMD64="v1"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.mod"
GOWORK=""
CGO_CFLAGS="-O2 -g"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-O2 -g"
CGO_FFLAGS="-O2 -g"
CGO_LDFLAGS="-O2 -g"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build1681865836=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 500bfdc41
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=500bfdc41735bc8d617cbfd4f1ab6b5980c8f1e5 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20231103-130513'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=500bfdc41735bc8d617cbfd4f1ab6b5980c8f1e5 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20231103-130513'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=500bfdc41735bc8d617cbfd4f1ab6b5980c8f1e5 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20231103-130513'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"500bfdc41735bc8d617cbfd4f1ab6b5980c8f1e5\"



Tested on:

commit:         b85ea95d Linux 6.7-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5bf1661f609e7f0
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10070d70e80000

