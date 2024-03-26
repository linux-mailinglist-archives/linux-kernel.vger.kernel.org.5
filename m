Return-Path: <linux-kernel+bounces-119701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3924E88CC35
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B821F81303
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2463E13C3D8;
	Tue, 26 Mar 2024 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbFPNoPB"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D33D129A6B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478757; cv=none; b=UchqZrJ07vg6xMzynjFVOTB3PC+Vtr4KTd1bzcDEL3ouI72UES0wA3f+BN2S4q2DDGEHt6jlHyPJHdfz8+UNlpD12MBQovS0pNtXaiIV4ryoNh1XmaCqbjptzx8oYi100PGRilg5I5apZQBJHPx7Ea5p5kF+SEIlwvbfL053AqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478757; c=relaxed/simple;
	bh=3NbIzqycd8xlypIi2qwc6u8vg1yB79by9UZm2rl/1PQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0XG/LVMuMDcA2ASnn/L6E1SVlAbMdtkdv2MZD45IEpll1Z2GTDkJRhab+NHfYNsu3WnutOZBo3Gy/dn5CuQ8A+4j85cxLD55oDxX3/WbNz/wbClrQjx5EfIz+hq1EBVoI7fuibIOPY7xD0AsapQKrCpskoPKOS/prp2m6/Cjpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbFPNoPB; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513d23be0b6so6991377e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711478753; x=1712083553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaewesxWwXF9SrBXj45sOscWiVNowam2VIxNVohVdmE=;
        b=fbFPNoPB4PIUvpH+af6m0udg8aZcKMR3Eo+tTbeFhDxqg1+DL9TMytTgUVp9Rr12PV
         wnDduDDsXP2nre7jfPJtTn0VQEFSKECzBQpPkfnyzoPWMHqgYO6bSG1NAWfbH9QdpPQI
         406ZW5G7KtfF319akZiTpP81ihYSBv/7G8bgYn3MGvLk3KbllSQXYhbAfkYI+Iv8MkNZ
         PEuSOvMiF/jJF5Drlf4DZs9sA3KfSC9z01GUaumLVahC9yUML3gJSv/IbjfUMaNerKt7
         MEhAaGLSyp5Gng95fBpvGK8m4VISzINcS3xHurzaDAOAMqBTOkjPrFPcEb+92FQMhzHh
         LUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711478753; x=1712083553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaewesxWwXF9SrBXj45sOscWiVNowam2VIxNVohVdmE=;
        b=rYyKN+87IcyfgyalDtkxF4ykTg1XvFcfAKFWqz/W+hcmx3M4yjG1axp83D0igM7QY1
         roug9H/yDGb0jQFqEcYg/SARVasOaOTH0Gyw8kFiBmqncXbatRAOowSjZXSeNO/k41Me
         siBFV+QgfPDVzGm6+o0/X+pzUNOL2ib3trJwlRksKP5hz3qsKe34Fquy5YFGPpej8qbd
         GG3w/+RrL9w/aC/0iY1sAjm50Q7bIiZQFm9A+n40W1n3ox2lJ4960OGm3MXKs3/i9SrZ
         uBXmit8RJjZFKfBt3ulHewgWKhvIvUFgprJsrH2mWuLaZQSBgmkrR8Udsk3/kHM4bok3
         cQ1A==
X-Gm-Message-State: AOJu0Yy/AncV6arqUe02OOTnIFhcdSaNNevTq5NcbYGMZzYr5WWVC60i
	Ig1dG6D4CipHXaTgu4Xo0AyBiOHWHmCPt51DG53aeO7WEpw1JZ5bt6nNjMP1
X-Google-Smtp-Source: AGHT+IEKaji2mkFAStyPQyPTfeOptFG+b5kG0FSe/18W2hU9ZFdWuxTEUoduwNOhrBUXf485wO4w4A==
X-Received: by 2002:ac2:5b87:0:b0:515:9313:572f with SMTP id o7-20020ac25b87000000b005159313572fmr8981273lfn.8.1711478753187;
        Tue, 26 Mar 2024 11:45:53 -0700 (PDT)
Received: from localhost.localdomain (109-252-14-191.nat.spd-mgts.ru. [109.252.14.191])
        by smtp.gmail.com with ESMTPSA id v20-20020ac25594000000b00513e6c170cdsm1580523lfg.254.2024.03.26.11.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 11:45:52 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: linux-kernel@vger.kernel.org
Cc: maximmosk4@gmail.com,
	Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
Subject: [PATCH 1/8] bpf: replace seq_puts by seq_putc
Date: Tue, 26 Mar 2024 21:45:49 +0300
Message-Id: <20240326184549.8555-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326184514.8478-1-Maxim.Moskalets@kaspersky.com>
References: <20240326184514.8478-1-Maxim.Moskalets@kaspersky.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using seq_putc for single characters is faster and more appropriate
than seq_puts, since only one character is passed and there is no need
to use a more powerful and less fast function.

Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
---
 kernel/bpf/arraymap.c       | 6 +++---
 kernel/bpf/bpf_struct_ops.c | 2 +-
 kernel/bpf/hashtab.c        | 4 ++--
 kernel/bpf/local_storage.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 13358675ff2e..d45bffe49dea 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -457,7 +457,7 @@ static void array_map_seq_show_elem(struct bpf_map *map, void *key,
 	if (map->btf_key_type_id)
 		seq_printf(m, "%u: ", *(u32 *)key);
 	btf_type_seq_show(map->btf, map->btf_value_type_id, value, m);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	rcu_read_unlock();
 }
@@ -478,7 +478,7 @@ static void percpu_array_map_seq_show_elem(struct bpf_map *map, void *key,
 		seq_printf(m, "\tcpu%d: ", cpu);
 		btf_type_seq_show(map->btf, map->btf_value_type_id,
 				  per_cpu_ptr(pptr, cpu), m);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 	seq_puts(m, "}\n");
 
@@ -955,7 +955,7 @@ static void prog_array_map_seq_show_elem(struct bpf_map *map, void *key,
 			prog_id = prog_fd_array_sys_lookup_elem(ptr);
 			btf_type_seq_show(map->btf, map->btf_value_type_id,
 					  &prog_id, m);
-			seq_puts(m, "\n");
+			seq_putc(m, '\n');
 		}
 	}
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 43356faaa057..bf94043f0975 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -833,7 +833,7 @@ static void bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void *key,
 		btf_type_seq_show(st_map->btf,
 				  map->btf_vmlinux_value_type_id,
 				  value, m);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 
 	kfree(value);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3a088a5349bc..db5105275545 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1577,7 +1577,7 @@ static void htab_map_seq_show_elem(struct bpf_map *map, void *key,
 	btf_type_seq_show(map->btf, map->btf_key_type_id, key, m);
 	seq_puts(m, ": ");
 	btf_type_seq_show(map->btf, map->btf_value_type_id, value, m);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	rcu_read_unlock();
 }
@@ -2421,7 +2421,7 @@ static void htab_percpu_map_seq_show_elem(struct bpf_map *map, void *key,
 		seq_printf(m, "\tcpu%d: ", cpu);
 		btf_type_seq_show(map->btf, map->btf_value_type_id,
 				  per_cpu_ptr(pptr, cpu), m);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 	seq_puts(m, "}\n");
 
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index a04f505aefe9..3969eb0382af 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -431,7 +431,7 @@ static void cgroup_storage_seq_show_elem(struct bpf_map *map, void *key,
 		seq_puts(m, ": ");
 		btf_type_seq_show(map->btf, map->btf_value_type_id,
 				  &READ_ONCE(storage->buf)->data[0], m);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	} else {
 		seq_puts(m, ": {\n");
 		for_each_possible_cpu(cpu) {
@@ -439,7 +439,7 @@ static void cgroup_storage_seq_show_elem(struct bpf_map *map, void *key,
 			btf_type_seq_show(map->btf, map->btf_value_type_id,
 					  per_cpu_ptr(storage->percpu_buf, cpu),
 					  m);
-			seq_puts(m, "\n");
+			seq_putc(m, '\n');
 		}
 		seq_puts(m, "}\n");
 	}
-- 
2.39.2


