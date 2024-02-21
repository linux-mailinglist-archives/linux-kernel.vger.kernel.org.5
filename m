Return-Path: <linux-kernel+bounces-73918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDF985CD96
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B66A5B23726
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429484C8A;
	Wed, 21 Feb 2024 01:54:52 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6F79C3;
	Wed, 21 Feb 2024 01:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480491; cv=none; b=D52Ofew8+haTqIdZ4Wdg1SIc7qxYRnWm+aj9Ao7dKA7foMvRqil3xxDZvIRoemHWNJfDkS8vlSaGdXSEj+LwOseth96cOyUF8tdClgFm7HirUQu1z2TYcG9QzPg+jhvveKXEc/KH2ZuJfBjJC+MXk7IFZYiSH7BtOquk//QwbXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480491; c=relaxed/simple;
	bh=qvvXGLRd2dBY05DP4mtYdzdlsgKW60gBnGie/EdUL2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZOJ+d5EZEVy7nXLbpAwYj7WDHxyZKOMB1A+beMG0ecP71RgPJMIGFpz8aVSepxCjphGa4CCr+83kVCkCKpezX/S72LGSNjvLlK1hdYjAAwTrtqEjQMEIg14hhS//c80gztrVKEeeEHHORo9penR1yaTClBP4yU/w4pWA10gIRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d751bc0c15so55490675ad.2;
        Tue, 20 Feb 2024 17:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708480489; x=1709085289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FChvkbuwuumTfTUfxOqNV1G/tDSl1t1W6EEos4crhQE=;
        b=eU5Aagydcuu7Cz3O3sPtzXnOLICma2rvMPyuSq8lQEMmOc3C7ayffHBHlDVjw2J/gd
         EWnXJF3HPn+XuWRKURLqhOnyfyYHJLsjbYI1Qo55r/BhVng3R5HXYz5gSRqEA0pJr30W
         BPpquLtvG2MlcIsQlAsvlKTrrAKoM0g9/PX5FKbvS4aK6agYaBeZplHr9awpp55qk+2o
         r47rFlhxCEtvRtVlvNt2D36iq3GrxPtqy61zQTMe5NmHQuIsS9q4fueGGAHs+npNINJ0
         tV81Nhc9NAVnKxpCEE49TID2+qXg9E9xRwOycwyVJ86+lYRwkBh4WX99UfazDAHSDILS
         wH2w==
X-Forwarded-Encrypted: i=1; AJvYcCX/sy03WG95UflXIjPmKNaqtrp8b4ApEPSWEIv1OyZ4qNQR6nkAoR93PEmwg19FtMCgnpCrQiMgNwHQY8QreD7d78ZpQg/iVxIph7mKQ4sWt/+RtOtp1DKSYI4slIobbMOO8Df7fh5RYQESFhBjog==
X-Gm-Message-State: AOJu0YyQwQsN6Ge558YmW4l1PPc2j8fDGHCdMgumaP3zg9gF7boxlF1p
	czRPkGiDxE7ehzZzVMMpplbzpW/FB20HwT44A9wrbSj/n4K0v+dUKzJKioVBtfl4L56xuWczZWY
	nPHqlZDzrtyQzDu7eZ9+gdUoJWYc=
X-Google-Smtp-Source: AGHT+IGyzooye3Mtp9/+LQQ5tOGpO5yTsTZeTRYtOS00j5v4qEYINRAmRiq8C50kD3wvA1K4tQ2saG/x04O0YqFvq9I=
X-Received: by 2002:a17:90a:c78a:b0:299:1f85:6fdc with SMTP id
 gn10-20020a17090ac78a00b002991f856fdcmr12494391pjb.48.1708480488882; Tue, 20
 Feb 2024 17:54:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216235203.229256-1-irogers@google.com> <20240216235203.229256-7-irogers@google.com>
In-Reply-To: <20240216235203.229256-7-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 20 Feb 2024 17:54:36 -0800
Message-ID: <CAM9d7cgavJtfVjcESq4HRvm9mvmRL9KrfO5HsTMPrgfLvxnymQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] perf tests: Use scandirat for shell script finding
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 3:55=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Avoid filename appending buffers by using openat, faccessat and
> scandirat more widely. Turn the script's path back to a file name
> using readlink from /proc/<pid>/fd/<fd>.
>
> Read the script's description using api/io.h to avoid fdopen
> conversions. Whilst reading perform additional sanity checks on the
> script's contents.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ditto.

  tests/tests-scripts.c: In function 'append_scripts_in_dir':
  tests/tests-scripts.c:200:18: error: implicit declaration of
function 'scandirat'; did you mean 'scandir'?
[-Werror=3Dimplicit-function-declaration]
  200 |         n_dirs =3D scandirat(dir_fd, ".", &entlist, NULL,
alphasort);
  |                  ^~~~~~~~~
  |                  scandir

Thanks,
Namhyung


> ---
>  tools/perf/tests/builtin-test.c  |  20 ++---
>  tools/perf/tests/tests-scripts.c | 144 ++++++++++++++++++-------------
>  tools/perf/tests/tests-scripts.h |   1 -
>  3 files changed, 94 insertions(+), 71 deletions(-)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index eff3c62e9b47..162f9eb090ac 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -300,22 +300,19 @@ static int test_and_print(struct test_suite *t, int=
 subtest)
>  }
>
>  struct shell_test {
> -       const char *dir;
>         const char *file;
>  };
>
>  static int shell_test__run(struct test_suite *test, int subdir __maybe_u=
nused)
>  {
>         int err;
> -       char script[PATH_MAX];
>         struct shell_test *st =3D test->priv;
> +       char *cmd =3D NULL;
>
> -       path__join(script, sizeof(script) - 3, st->dir, st->file);
> -
> -       if (verbose > 0)
> -               strncat(script, " -v", sizeof(script) - strlen(script) - =
1);
> -
> -       err =3D system(script);
> +       if (asprintf(&cmd, "%s%s", st->file, verbose ? " -v" : "") < 0)
> +               return TEST_FAIL;
> +       err =3D system(cmd);
> +       free(cmd);
>         if (!err)
>                 return TEST_OK;
>
> @@ -331,7 +328,7 @@ static int run_shell_tests(int argc, const char *argv=
[], int i, int width,
>         files =3D list_script_files();
>         if (!files)
>                 return 0;
> -       for (file =3D files; file->dir; file++) {
> +       for (file =3D files; file->file; file++) {
>                 int curr =3D i++;
>                 struct test_case test_cases[] =3D {
>                         {
> @@ -345,13 +342,12 @@ static int run_shell_tests(int argc, const char *ar=
gv[], int i, int width,
>                         .test_cases =3D test_cases,
>                         .priv =3D &st,
>                 };
> -               st.dir =3D file->dir;
> +               st.file =3D file->file;
>
>                 if (test_suite.desc =3D=3D NULL ||
>                     !perf_test__matches(test_suite.desc, curr, argc, argv=
))
>                         continue;
>
> -               st.file =3D file->file;
>                 pr_info("%3d: %-*s:", i, width, test_suite.desc);
>
>                 if (intlist__find(skiplist, i)) {
> @@ -455,7 +451,7 @@ static int perf_test__list_shell(int argc, const char=
 **argv, int i)
>         files =3D list_script_files();
>         if (!files)
>                 return 0;
> -       for (file =3D files; file->dir; file++) {
> +       for (file =3D files; file->file; file++) {
>                 int curr =3D i++;
>                 struct test_suite t =3D {
>                         .desc =3D file->desc
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index 4ebd841da05b..9b3b66dd5508 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -14,6 +14,7 @@
>  #include <subcmd/parse-options.h>
>  #include <sys/wait.h>
>  #include <sys/stat.h>
> +#include <api/io.h>
>  #include "builtin.h"
>  #include "tests-scripts.h"
>  #include "color.h"
> @@ -35,55 +36,69 @@ static size_t files_num =3D 0;
>  static struct script_file *files =3D NULL;
>  static int files_max_width =3D 0;
>
> -static const char *shell_tests__dir(char *path, size_t size)
> +static int shell_tests__dir_fd(void)
>  {
> -       const char *devel_dirs[] =3D { "./tools/perf/tests", "./tests", }=
;
> -       char *exec_path;
> -       unsigned int i;
> +       char path[PATH_MAX], *exec_path;
> +       static const char * const devel_dirs[] =3D { "./tools/perf/tests/=
shell", "./tests/shell", };
>
> -       for (i =3D 0; i < ARRAY_SIZE(devel_dirs); ++i) {
> -               struct stat st;
> +       for (size_t i =3D 0; i < ARRAY_SIZE(devel_dirs); ++i) {
> +               int fd =3D open(devel_dirs[i], O_PATH);
>
> -               if (!lstat(devel_dirs[i], &st)) {
> -                       scnprintf(path, size, "%s/shell", devel_dirs[i]);
> -                       if (!lstat(devel_dirs[i], &st))
> -                               return path;
> -               }
> +               if (fd >=3D 0)
> +                       return fd;
>         }
>
>         /* Then installed path. */
>         exec_path =3D get_argv_exec_path();
> -       scnprintf(path, size, "%s/tests/shell", exec_path);
> +       scnprintf(path, sizeof(path), "%s/tests/shell", exec_path);
>         free(exec_path);
> -       return path;
> +       return open(path, O_PATH);
>  }
>
> -static const char *shell_test__description(char *description, size_t siz=
e,
> -                                           const char *path, const char =
*name)
> +static char *shell_test__description(int dir_fd, const char *name)
>  {
> -       FILE *fp;
> -       char filename[PATH_MAX];
> -       int ch;
> +       struct io io;
> +       char buf[128], desc[256];
> +       int ch, pos =3D 0;
>
> -       path__join(filename, sizeof(filename), path, name);
> -       fp =3D fopen(filename, "r");
> -       if (!fp)
> +       io__init(&io, openat(dir_fd, name, O_RDONLY), buf, sizeof(buf));
> +       if (io.fd < 0)
>                 return NULL;
>
>         /* Skip first line - should be #!/bin/sh Shebang */
> +       if (io__get_char(&io) !=3D '#')
> +               goto err_out;
> +       if (io__get_char(&io) !=3D '!')
> +               goto err_out;
>         do {
> -               ch =3D fgetc(fp);
> -       } while (ch !=3D EOF && ch !=3D '\n');
> -
> -       description =3D fgets(description, size, fp);
> -       fclose(fp);
> +               ch =3D io__get_char(&io);
> +               if (ch < 0)
> +                       goto err_out;
> +       } while (ch !=3D '\n');
>
> -       /* Assume first char on line is omment everything after that desc=
 */
> -       return description ? strim(description + 1) : NULL;
> +       do {
> +               ch =3D io__get_char(&io);
> +               if (ch < 0)
> +                       goto err_out;
> +       } while (ch =3D=3D '#' || isspace(ch));
> +       while (ch > 0 && ch !=3D '\n') {
> +               desc[pos++] =3D ch;
> +               if (pos >=3D (int)sizeof(desc) - 1)
> +                       break;
> +               ch =3D io__get_char(&io);
> +       }
> +       while (pos > 0 && isspace(desc[--pos]))
> +               ;
> +       desc[++pos] =3D '\0';
> +       close(io.fd);
> +       return strdup(desc);
> +err_out:
> +       close(io.fd);
> +       return NULL;
>  }
>
>  /* Is this full file path a shell script */
> -static bool is_shell_script(const char *path)
> +static bool is_shell_script(int dir_fd, const char *path)
>  {
>         const char *ext;
>
> @@ -91,20 +106,16 @@ static bool is_shell_script(const char *path)
>         if (!ext)
>                 return false;
>         if (!strcmp(ext, ".sh")) { /* Has .sh extension */
> -               if (access(path, R_OK | X_OK) =3D=3D 0) /* Is executable =
*/
> +               if (faccessat(dir_fd, path, R_OK | X_OK, 0) =3D=3D 0) /* =
Is executable */
>                         return true;
>         }
>         return false;
>  }
>
>  /* Is this file in this dir a shell script (for test purposes) */
> -static bool is_test_script(const char *path, const char *name)
> +static bool is_test_script(int dir_fd, const char *name)
>  {
> -       char filename[PATH_MAX];
> -
> -       path__join(filename, sizeof(filename), path, name);
> -       if (!is_shell_script(filename)) return false;
> -       return true;
> +       return is_shell_script(dir_fd, name);
>  }
>
>  /* Duplicate a string and fall over and die if we run out of memory */
> @@ -120,12 +131,21 @@ static char *strdup_check(const char *str)
>         return newstr;
>  }
>
> -static void append_script(const char *dir, const char *file, const char =
*desc)
> +static void append_script(int dir_fd, const char *name, char *desc)
>  {
> +       char filename[PATH_MAX], link[128];
>         struct script_file *files_tmp;
> -       size_t files_num_tmp;
> +       size_t files_num_tmp, len;
>         int width;
>
> +       snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
> +       len =3D readlink(link, filename, sizeof(filename));
> +       if (len < 0) {
> +               pr_err("Failed to readlink %s", link);
> +               return;
> +       }
> +       filename[len++] =3D '/';
> +       strcpy(&filename[len], name);
>         files_num_tmp =3D files_num + 1;
>         if (files_num_tmp >=3D SIZE_MAX) {
>                 pr_err("Too many script files\n");
> @@ -142,10 +162,8 @@ static void append_script(const char *dir, const cha=
r *file, const char *desc)
>         /* Add file to end and NULL terminate the struct array */
>         files =3D files_tmp;
>         files_num =3D files_num_tmp;
> -       files[files_num - 1].dir =3D strdup_check(dir);
> -       files[files_num - 1].file =3D strdup_check(file);
> -       files[files_num - 1].desc =3D strdup_check(desc);
> -       files[files_num].dir =3D NULL;
> +       files[files_num - 1].file =3D strdup_check(filename);
> +       files[files_num - 1].desc =3D desc;
>         files[files_num].file =3D NULL;
>         files[files_num].desc =3D NULL;
>
> @@ -154,32 +172,39 @@ static void append_script(const char *dir, const ch=
ar *file, const char *desc)
>                 files_max_width =3D width;
>  }
>
> -static void append_scripts_in_dir(const char *path)
> +static void append_scripts_in_dir(int dir_fd)
>  {
>         struct dirent **entlist;
>         struct dirent *ent;
>         int n_dirs, i;
> -       char filename[PATH_MAX];
>
>         /* List files, sorted by alpha */
> -       n_dirs =3D scandir(path, &entlist, NULL, alphasort);
> +       n_dirs =3D scandirat(dir_fd, ".", &entlist, NULL, alphasort);
>         if (n_dirs =3D=3D -1)
>                 return;
>         for (i =3D 0; i < n_dirs && (ent =3D entlist[i]); i++) {
> +               int fd;
> +
>                 if (ent->d_name[0] =3D=3D '.')
>                         continue; /* Skip hidden files */
> -               if (is_test_script(path, ent->d_name)) { /* It's a test *=
/
> -                       char bf[256];
> -                       const char *desc =3D shell_test__description
> -                               (bf, sizeof(bf), path, ent->d_name);
> +               if (is_test_script(dir_fd, ent->d_name)) { /* It's a test=
 */
> +                       char *desc =3D shell_test__description(dir_fd, en=
t->d_name);
>
>                         if (desc) /* It has a desc line - valid script */
> -                               append_script(path, ent->d_name, desc);
> -               } else if (is_directory(path, ent)) { /* Scan the subdir =
*/
> -                       path__join(filename, sizeof(filename),
> -                                  path, ent->d_name);
> -                       append_scripts_in_dir(filename);
> +                               append_script(dir_fd, ent->d_name, desc);
> +                       continue;
> +               }
> +               if (ent->d_type !=3D DT_DIR) {
> +                       struct stat st;
> +
> +                       if (ent->d_type !=3D DT_UNKNOWN)
> +                               continue;
> +                       fstatat(dir_fd, ent->d_name, &st, 0);
> +                       if (!S_ISDIR(st.st_mode))
> +                               continue;
>                 }
> +               fd =3D openat(dir_fd, ent->d_name, O_PATH);
> +               append_scripts_in_dir(fd);
>         }
>         for (i =3D 0; i < n_dirs; i++) /* Clean up */
>                 zfree(&entlist[i]);
> @@ -188,14 +213,17 @@ static void append_scripts_in_dir(const char *path)
>
>  const struct script_file *list_script_files(void)
>  {
> -       char path_dir[PATH_MAX];
> -       const char *path;
> +       int dir_fd;
>
>         if (files)
>                 return files; /* Singleton - we already know our list */
>
> -       path =3D shell_tests__dir(path_dir, sizeof(path_dir)); /* Walk  d=
ir */
> -       append_scripts_in_dir(path);
> +       dir_fd =3D shell_tests__dir_fd(); /* Walk  dir */
> +       if (dir_fd < 0)
> +               return NULL;
> +
> +       append_scripts_in_dir(dir_fd);
> +       close(dir_fd);
>
>         return files;
>  }
> diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-sc=
ripts.h
> index 3a3ec6191848..3508a293aaf9 100644
> --- a/tools/perf/tests/tests-scripts.h
> +++ b/tools/perf/tests/tests-scripts.h
> @@ -3,7 +3,6 @@
>  #define TESTS_SCRIPTS_H
>
>  struct script_file {
> -       char *dir;
>         char *file;
>         char *desc;
>  };
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

